Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF321BDA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgGJTaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 15:30:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59976 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJTaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:30:16 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5D7BA20B4908;
        Fri, 10 Jul 2020 12:30:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D7BA20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594409415;
        bh=M5dLai7mNPTd3Wnd//DTj/dm1yHRr0oCnAgp9ujOkD8=;
        h=From:To:Cc:Subject:Date:From;
        b=YKZiudmmJuux776Gb7yQajdAQBsRCOW9jSfLOtuGDBimDfr16dcP7wKxKlh1pfVnR
         zXv6BvtTcdmAc1TLEdlP+BdqQ5ysWYwSkUPZhK24zsl3qp9zpBY6rPQwCPxoX8FEUo
         RAbZXYzjfCVhZzojdfIul0DSPnRoxpBlGHcIOBTU=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Petr Vandrovec <petr@vmware.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        linux-integrity@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>
Subject: [PATCH v2] tpm: Require that all digests are present in TCG_PCR_EVENT2 structures
Date:   Fri, 10 Jul 2020 14:29:55 -0500
Message-Id: <20200710192955.23333-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Require that the TCG_PCR_EVENT2.digests.count value strictly matches the
value of TCG_EfiSpecIdEvent.numberOfAlgorithms in the event field of the
TCG_PCClientPCREvent event log header. Also require that
TCG_EfiSpecIdEvent.numberOfAlgorithms is non-zero.

The TCG PC Client Platform Firmware Profile Specification section 9.1
(Family "2.0", Level 00 Revision 1.04) states:

 For each Hash algorithm enumerated in the TCG_PCClientPCREvent entry,
 there SHALL be a corresponding digest in all TCG_PCR_EVENT2 structures.
 Note: This includes EV_NO_ACTION events which do not extend the PCR.

Section 9.4.5.1 provides this description of
TCG_EfiSpecIdEvent.numberOfAlgorithms:

 The number of Hash algorithms in the digestSizes field. This field MUST
 be set to a value of 0x01 or greater.

Enforce these restrictions, as required by the above specification, in
order to better identify and ignore invalid sequences of bytes at the
end of an otherwise valid TPM2 event log. Firmware doesn't always have
the means necessary to inform the kernel of the actual event log size so
the kernel's event log parsing code should be stringent when parsing the
event log for resiliency against firmware bugs. This is true, for
example, when firmware passes the event log to the kernel via a reserved
memory region described in device tree.

POWER and some ARM systems use the "linux,sml-base" and "linux,sml-size"
device tree properties to describe the memory region used to pass the
event log from firmware to the kernel. Unfortunately, the
"linux,sml-size" property describes the size of the entire reserved
memory region rather than the size of the event long within the memory
region and the event log format does not include information describing
the size of the event log.

tpm_read_log_of(), in drivers/char/tpm/eventlog/of.c, is where the
"linux,sml-size" property is used. At the end of that function,
log->bios_event_log_end is pointing at the end of the reserved memory
region. That's typically 0x10000 bytes offset from "linux,sml-base",
depending on what's defined in the device tree source.

The firmware event log only fills a portion of those 0x10000 bytes and
the rest of the memory region should be zeroed out by firmware. Even in
the case of a properly zeroed bytes in the remainder of the memory
region, the only thing allowing the kernel's event log parser to detect
the end of the event log is the following conditional in
__calc_tpm2_event_size():

        if (event_type == 0 && event_field->event_size == 0)
                size = 0;

If that wasn't there, __calc_tpm2_event_size() would think that a 16
byte sequence of zeroes, following an otherwise valid event log, was
a valid event.

However, problems can occur if a single bit is set in the offset
corresponding to either the TCG_PCR_EVENT2.eventType or
TCG_PCR_EVENT2.eventSize fields, after the last valid event log entry.
This could confuse the parser into thinking that an additional entry is
present in the event log and exposing this invalid entry to userspace in
the /sys/kernel/security/tpm0/binary_bios_measurements file. Such
problems have been seen if firmware does not fully zero the memory
region upon a warm reboot.

This patch significantly raises the bar on how difficult it is for
stale/invalid memory to confuse the kernel's event log parser but
there's still, ultimately, a reliance on firmware to properly initialize
the remainder of the memory region reserved for the event log as the
parser cannot be expected to detect a stale but otherwise properly
formatted firmware event log entry.

Fixes: fd5c78694f3f ("tpm: fix handling of the TPM 2.0 event logs")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v2
  - Rebase the patch on top of the TPM next branch, commit 786a2aa281f4
    ("Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102")")
  - Expand on the technical reasoning for needing strict event
    validation in the commit message
  - Improve the inline comment explaining the need for detecting
    malformed events

 include/linux/tpm_eventlog.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 64356b199e94..739ba9a03ec1 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -211,9 +211,16 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
-	/* Check if event is malformed. */
+	/*
+	 * Perform validation of the event in order to identify malformed
+	 * events. This function may be asked to parse arbitrary byte sequences
+	 * immediately following a valid event log. The caller expects this
+	 * function to recognize that the byte sequence is not a valid event
+	 * and to return an event size of 0.
+	 */
 	if (memcmp(efispecid->signature, TCG_SPECID_SIG,
-		   sizeof(TCG_SPECID_SIG)) || count > efispecid->num_algs) {
+		   sizeof(TCG_SPECID_SIG)) ||
+	    !efispecid->num_algs || count != efispecid->num_algs) {
 		size = 0;
 		goto out;
 	}
-- 
2.25.1

