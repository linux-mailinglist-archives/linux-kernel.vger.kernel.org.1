Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9881FB600
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgFPPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 11:22:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47596 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbgFPPWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:22:40 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7571620B4780;
        Tue, 16 Jun 2020 08:22:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7571620B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592320959;
        bh=bYENIh5GedrqWYBC1j3ZP9ozD3HNqpdatcHseK3/Bhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BquU+tpQEmnqTALGYHLqisl8YefG8C6psRehVL+11NSxeC/A+i+j/KRlONbn42HyY
         S8zxr2Sg1B4Ckll8k8yTThERyNooYDF7lEiDulR4/3JiIMzOBAo5HIyUgfOSBCWK/L
         0xyZbVWkbDN0oiDppCGPKDblFxZ7zLFCwpnyETOU=
Date:   Tue, 16 Jun 2020 10:22:28 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Petr Vandrovec <petr@vmware.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures
Message-ID: <20200616152228.GA1409697@sequoia>
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
 <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-16 11:08:38, Ard Biesheuvel wrote:
> (cc Matthew and Peter)

Thanks!

> On Tue, 16 Jun 2020 at 01:28, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> >
> > Require that the TCG_PCR_EVENT2.digests.count value strictly matches the
> > value of TCG_EfiSpecIdEvent.numberOfAlgorithms in the event field of the
> > TCG_PCClientPCREvent event log header. Also require that
> > TCG_EfiSpecIdEvent.numberOfAlgorithms is non-zero.
> >
> > The TCG PC Client Platform Firmware Profile Specification section 9.1
> > (Family "2.0", Level 00 Revision 1.04) states:
> >
> >  For each Hash algorithm enumerated in the TCG_PCClientPCREvent entry,
> >  there SHALL be a corresponding digest in all TCG_PCR_EVENT2 structures.
> >  Note: This includes EV_NO_ACTION events which do not extend the PCR.
> >
> > Section 9.4.5.1 provides this description of
> > TCG_EfiSpecIdEvent.numberOfAlgorithms:
> >
> >  The number of Hash algorithms in the digestSizes field. This field MUST
> >  be set to a value of 0x01 or greater.
> >
> > Enforce these restrictions, as required by the above specification, in
> > order to better identify and ignore invalid sequences of bytes at the
> > end of an otherwise valid TPM2 event log. Firmware doesn't always have
> > the means necessary to inform the kernel of the actual event log size so
> > the kernel's event log parsing code should be stringent when parsing the
> > event log for resiliency against firmware bugs. This is true, for
> > example, when firmware passes the event log to the kernel via a reserved
> > memory region described in device tree.
> >
> 
> When does this happen? Do we have code in mainline that does this?

We do. POWER and some ARM firmware that pass the firmware event log via
"linux,sml-base" and "linux,sml-size" properties:

 https://open-power.github.io/skiboot/doc/device-tree/tpm.html

The "linux,sml-size" property is the size of the memory region dedicated
to the firmware event log and not the size of the firmware event log
itself.

tpm_read_log_of() in drivers/char/tpm/eventlog/of.c is where this
property is used. At the end of that function, log->bios_event_log_end
is pointing at the end of the reserved memory region. That's typically
0x10000 bytes offset from "linux,sml-base", depending on what's defined
in the device tree source.

I suspect that ACPI event log support may be implemented similarly, from
skimming tpm_read_log_acpi() and the TCG ACPI Specification, but I don't
know for sure.


Anyways, you wouldn't know from reading __calc_tpm2_event_size() but the
only thing allowing the kernel's event log parser to work on these
systems that don't inform the kernel of the actual firmware event log
size is the following conditional and assignment in
__calc_tpm2_event_size():

	if (event_type == 0 && event_field->event_size == 0)
		size = 0;

If that wasn't there, __calc_tpm2_event_size() would think that a 16
byte sequence of zeroes was a valid event.

> > Prior to this patch, a single bit set in the offset corresponding to
> > either the TCG_PCR_EVENT2.eventType or TCG_PCR_EVENT2.eventSize fields,
> > after the last valid event log entry, could confuse the parser into
> > thinking that an additional entry is present in the event log. This
> > patch raises the bar on how difficult it is for stale memory to confuse
> > the kernel's event log parser but there's still a reliance on firmware
> > to properly initialize the remainder of the memory region reserved for
> > the event log as the parser cannot be expected to detect a stale but
> > otherwise properly formatted firmware event log entry.
> >
> > Fixes: fd5c78694f3f ("tpm: fix handling of the TPM 2.0 event logs")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> 
> I am all for stringent checks, but this could potentially break
> measured boot on systems that are working fine today, right?

Yes, I think there is some risk in breaking existing systems that aren't
conforming to the spec. I'm no expert in this area so I can't say how
high the risk is. I think __calc_tpm2_event_size() is only used for
exposing the TPM2 firmware event log to userspace and then attestation
services make use of it from there. Breakage would cause the kernel to
not fully expose the firmware event log to userspace via
/sys/kernel/security/tpm*/binary_bios_measurements and that could result
in attestation failures that cause these systems to be marked as
untrusted.

I'm not in a hurry to get this merged and welcome as much feedback as
possible on the risks involved as well as my understanding of the TCG PC
Client Platform Firmware Profile Specification.

Tyler

> 
> >  include/linux/tpm_eventlog.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> > index 4f8c90c93c29..d83eb9fd5614 100644
> > --- a/include/linux/tpm_eventlog.h
> > +++ b/include/linux/tpm_eventlog.h
> > @@ -201,7 +201,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> >         efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
> >
> >         /* Check if event is malformed. */
> > -       if (count > efispecid->num_algs) {
> > +       if (!efispecid->num_algs || count != efispecid->num_algs) {
> >                 size = 0;
> >                 goto out;
> >         }
> > --
> > 2.25.1
> >
