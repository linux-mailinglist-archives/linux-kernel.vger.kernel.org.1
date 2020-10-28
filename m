Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E629DF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403985AbgJ2A76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731541AbgJ1WR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:29 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CAA0247DE;
        Wed, 28 Oct 2020 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895016;
        bh=pC6vJFCRfPc6S6sZQQ4e6FxoyMZp7ozbkGpzyTaHp9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fb4gui6n9rYBzb5RaP43KT7w5ddUDOkUrVRA8lJES3PpjN8ig53ef/28I8msEKEJh
         X0SfpmhugXkT7KctrFAO/3OgiW58lvINM17jBJaBvH21tm30mQO20Ff9XYfI4v0wxR
         SSPfGz3mAL4s4g1fCzMUTaCf1rDihhY2ZssD6iE0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMP-003hmC-Ve; Wed, 28 Oct 2020 15:23:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek Behun <marek.behun@nic.cz>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 31/33] docs: ABI: change read/write attributes
Date:   Wed, 28 Oct 2020 15:23:29 +0100
Message-Id: <78ba294664e4886af3fe9376ec3c14abe088368e.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, (R) and (W) are valid markups for enumerated
lists, as described at:
	https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#enumerated-lists

So, we ned to replace them by:

	(R) -> (Read)
	(W) -> (Write)

As otherwise, (R) will be displayed as R., with is not what
it is desired.

There's no need to touch (RO) and (RW).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/debugfs-moxtet      |  2 +-
 .../ABI/testing/debugfs-turris-mox-rwtm       | 15 ++--
 .../testing/sysfs-bus-coresight-devices-cti   | 60 +++++++--------
 .../testing/sysfs-bus-coresight-devices-etb10 | 16 ++--
 .../testing/sysfs-bus-coresight-devices-etm3x | 10 +--
 .../testing/sysfs-bus-coresight-devices-etm4x | 76 +++++++++----------
 .../testing/sysfs-bus-coresight-devices-stm   |  2 +-
 .../testing/sysfs-bus-coresight-devices-tmc   | 20 ++---
 .../ABI/testing/sysfs-bus-moxtet-devices      |  6 +-
 .../testing/sysfs-firmware-turris-mox-rwtm    | 10 +--
 10 files changed, 109 insertions(+), 108 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-moxtet b/Documentation/ABI/testing/debugfs-moxtet
index 15dfaecb2892..6eee10c3d5a1 100644
--- a/Documentation/ABI/testing/debugfs-moxtet
+++ b/Documentation/ABI/testing/debugfs-moxtet
@@ -2,7 +2,7 @@ What:		/sys/kernel/debug/moxtet/input
 Date:		March 2019
 KernelVersion:	5.3
 Contact:	Marek Behún <marek.behun@nic.cz>
-Description:	(R) Read input from the shift registers, in hexadecimal.
+Description:	(Read) Read input from the shift registers, in hexadecimal.
 		Returns N+1 bytes, where N is the number of Moxtet connected
 		modules. The first byte is from the CPU board itself.
 
diff --git a/Documentation/ABI/testing/debugfs-turris-mox-rwtm b/Documentation/ABI/testing/debugfs-turris-mox-rwtm
index ad08f535af3b..326df1b74707 100644
--- a/Documentation/ABI/testing/debugfs-turris-mox-rwtm
+++ b/Documentation/ABI/testing/debugfs-turris-mox-rwtm
@@ -4,10 +4,11 @@ KernelVersion:	5.8
 Contact:	Marek Behún <marek.behun@nic.cz>
 Description:
 
-		=== ===========================================================
-		(W) Message to sign with the ECDSA private key stored in
-		    device's OTP. The message must be exactly 64 bytes (since
-		    this is intended for SHA-512 hashes).
-		(R) The resulting signature, 136 bytes. This contains the R and
-		    S values of the ECDSA signature, both in big-endian format.
-		=== ===========================================================
+		======= ===========================================================
+		(Write) Message to sign with the ECDSA private key stored in
+		        device's OTP. The message must be exactly 64 bytes
+		        (since this is intended for SHA-512 hashes).
+		(Read)  The resulting signature, 136 bytes. This contains the
+			R and S values of the ECDSA signature, both in
+			big-endian format.
+		======= ===========================================================
diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti b/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
index 9d11502b4390..bf2869c413e7 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
@@ -8,50 +8,50 @@ What:		/sys/bus/coresight/devices/<cti-name>/powered
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Indicate if the CTI hardware is powered.
+Description:	(Read) Indicate if the CTI hardware is powered.
 
 What:		/sys/bus/coresight/devices/<cti-name>/ctmid
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Display the associated CTM ID
+Description:	(Read) Display the associated CTM ID
 
 What:		/sys/bus/coresight/devices/<cti-name>/nr_trigger_cons
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Number of devices connected to triggers on this CTI
+Description:	(Read) Number of devices connected to triggers on this CTI
 
 What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/name
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Name of connected device <N>
+Description:	(Read) Name of connected device <N>
 
 What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/in_signals
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Input trigger signals from connected device <N>
+Description:	(Read) Input trigger signals from connected device <N>
 
 What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/in_types
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Functional types for the input trigger signals
+Description:	(Read) Functional types for the input trigger signals
 		from connected device <N>
 
 What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/out_signals
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Output trigger signals to connected device <N>
+Description:	(Read) Output trigger signals to connected device <N>
 
 What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/out_types
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Functional types for the output trigger signals
+Description:	(Read) Functional types for the output trigger signals
 		to connected device <N>
 
 What:		/sys/bus/coresight/devices/<cti-name>/regs/inout_sel
@@ -88,7 +88,7 @@ What:		/sys/bus/coresight/devices/<cti-name>/regs/intack
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Write the INTACK register.
+Description:	(Write) Write the INTACK register.
 
 What:		/sys/bus/coresight/devices/<cti-name>/regs/appset
 Date:		March 2020
@@ -101,99 +101,99 @@ What:		/sys/bus/coresight/devices/<cti-name>/regs/appclear
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Write APPCLEAR register to deactivate channel.
+Description:	(Write) Write APPCLEAR register to deactivate channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/regs/apppulse
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Write APPPULSE to pulse a channel active for one clock
+Description:	(Write) Write APPPULSE to pulse a channel active for one clock
 		cycle.
 
 What:		/sys/bus/coresight/devices/<cti-name>/regs/chinstatus
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Read current status of channel inputs.
+Description:	(Read) Read current status of channel inputs.
 
 What:		/sys/bus/coresight/devices/<cti-name>/regs/choutstatus
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) read current status of channel outputs.
+Description:	(Read) read current status of channel outputs.
 
 What:		/sys/bus/coresight/devices/<cti-name>/regs/triginstatus
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) read current status of input trigger signals
+Description:	(Read) read current status of input trigger signals
 
 What:		/sys/bus/coresight/devices/<cti-name>/regs/trigoutstatus
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) read current status of output trigger signals.
+Description:	(Read) read current status of output trigger signals.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/trigin_attach
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Attach a CTI input trigger to a CTM channel.
+Description:	(Write) Attach a CTI input trigger to a CTM channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/trigin_detach
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Detach a CTI input trigger from a CTM channel.
+Description:	(Write) Detach a CTI input trigger from a CTM channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/trigout_attach
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Attach a CTI output trigger to a CTM channel.
+Description:	(Write) Attach a CTI output trigger to a CTM channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/trigout_detach
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Detach a CTI output trigger from a CTM channel.
+Description:	(Write) Detach a CTI output trigger from a CTM channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_gate_enable
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(RW) Enable CTIGATE for single channel (W) or list enabled
+Description:	(RW) Enable CTIGATE for single channel (Write) or list enabled
 		channels through the gate (R).
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_gate_disable
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Disable CTIGATE for single channel.
+Description:	(Write) Disable CTIGATE for single channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_set
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Activate a single channel.
+Description:	(Write) Activate a single channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_clear
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Deactivate a single channel.
+Description:	(Write) Deactivate a single channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_pulse
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Pulse a single channel - activate for a single clock cycle.
+Description:	(Write) Pulse a single channel - activate for a single clock cycle.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/trigout_filtered
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) List of output triggers filtered across all connections.
+Description:	(Read) List of output triggers filtered across all connections.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/trig_filter_enable
 Date:		March 2020
@@ -205,13 +205,13 @@ What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_inuse
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) show channels with at least one attached trigger signal.
+Description:	(Read) show channels with at least one attached trigger signal.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_free
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) show channels with no attached trigger signals.
+Description:	(Read) show channels with no attached trigger signals.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_xtrigs_sel
 Date:		March 2020
@@ -224,18 +224,18 @@ What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_xtrigs_in
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Read to see input triggers connected to selected view
+Description:	(Read) Read to see input triggers connected to selected view
 		channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_xtrigs_out
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(R) Read to see output triggers connected to selected view
+Description:	(Read) Read to see output triggers connected to selected view
 		channel.
 
 What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_xtrigs_reset
 Date:		March 2020
 KernelVersion	5.7
 Contact:	Mike Leach or Mathieu Poirier
-Description:	(W) Clear all channel / trigger programming.
+Description:	(Write) Clear all channel / trigger programming.
diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10 b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10
index 3e92cbd3fd83..9a383f6a74eb 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10
@@ -23,21 +23,21 @@ What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/rdp
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Defines the depth, in words, of the trace RAM in powers of
+Description:	(Read) Defines the depth, in words, of the trace RAM in powers of
 		2.  The value is read directly from HW register RDP, 0x004.
 
 What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/sts
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the ETB status register.  The value
+Description:	(Read) Shows the value held by the ETB status register.  The value
 		is read directly from HW register STS, 0x00C.
 
 What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/rrp
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the ETB RAM Read Pointer register
+Description:	(Read) Shows the value held by the ETB RAM Read Pointer register
 		that is used to read entries from the Trace RAM over the APB
 		interface.  The value is read directly from HW register RRP,
 		0x014.
@@ -46,7 +46,7 @@ What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/rwp
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the ETB RAM Write Pointer register
+Description:	(Read) Shows the value held by the ETB RAM Write Pointer register
 		that is used to sets the write pointer to write entries from
 		the CoreSight bus into the Trace RAM. The value is read directly
 		from HW register RWP, 0x018.
@@ -55,21 +55,21 @@ What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/trg
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Similar to "trigger_cntr" above except that this value is
+Description:	(Read) Similar to "trigger_cntr" above except that this value is
 		read directly from HW register TRG, 0x01C.
 
 What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/ctl
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the ETB Control register. The value
+Description:	(Read) Shows the value held by the ETB Control register. The value
 		is read directly from HW register CTL, 0x020.
 
 What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/ffsr
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the ETB Formatter and Flush Status
+Description:	(Read) Shows the value held by the ETB Formatter and Flush Status
 		register.  The value is read directly from HW register FFSR,
 		0x300.
 
@@ -77,6 +77,6 @@ What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/ffcr
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the ETB Formatter and Flush Control
+Description:	(Read) Shows the value held by the ETB Formatter and Flush Control
 		register.  The value is read directly from HW register FFCR,
 		0x304.
diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
index 924265a1295d..651602a61eac 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
@@ -146,28 +146,28 @@ What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/nr_addr_cmp
 Date:		November 2014
 KernelVersion:	3.19
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(R) Provides the number of address comparators pairs accessible
+Description: 	(Read) Provides the number of address comparators pairs accessible
 		on a trace unit, as specified by bit 3:0 of register ETMCCR.
 
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/nr_cntr
 Date:		November 2014
 KernelVersion:	3.19
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(R) Provides the number of counters accessible on a trace unit,
+Description: 	(Read) Provides the number of counters accessible on a trace unit,
 		as specified by bit 15:13 of register ETMCCR.
 
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/nr_ctxid_cmp
 Date:		November 2014
 KernelVersion:	3.19
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(R) Provides the number of context ID comparator available on a
+Description: 	(Read) Provides the number of context ID comparator available on a
 		trace unit, as specified by bit 25:24 of register ETMCCR.
 
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/reset
 Date:		November 2014
 KernelVersion:	3.19
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(W) Cancels all configuration on a trace unit and set it back
+Description: 	(Write) Cancels all configuration on a trace unit and set it back
 		to its boot configuration.
 
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/seq_12_event
@@ -216,7 +216,7 @@ What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/curr_seq_state
 Date:		November 2014
 KernelVersion:	3.19
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(R) Holds the current state of the sequencer.
+Description: 	(Read) Holds the current state of the sequencer.
 
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/sync_freq
 Date:		November 2014
diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
index 614874e2cf53..881f0cd99ce4 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
@@ -12,75 +12,75 @@ What:		/sys/bus/coresight/devices/etm<N>/cpu
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) The CPU this tracing entity is associated with.
+Description:	(Read) The CPU this tracing entity is associated with.
 
 What:		/sys/bus/coresight/devices/etm<N>/nr_pe_cmp
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates the number of PE comparator inputs that are
+Description:	(Read) Indicates the number of PE comparator inputs that are
 		available for tracing.
 
 What:		/sys/bus/coresight/devices/etm<N>/nr_addr_cmp
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates the number of address comparator pairs that are
+Description:	(Read) Indicates the number of address comparator pairs that are
 		available for tracing.
 
 What:		/sys/bus/coresight/devices/etm<N>/nr_cntr
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates the number of counters that are available for
+Description:	(Read) Indicates the number of counters that are available for
 		tracing.
 
 What:		/sys/bus/coresight/devices/etm<N>/nr_ext_inp
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates how many external inputs are implemented.
+Description:	(Read) Indicates how many external inputs are implemented.
 
 What:		/sys/bus/coresight/devices/etm<N>/numcidc
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates the number of Context ID comparators that are
+Description:	(Read) Indicates the number of Context ID comparators that are
 		available for tracing.
 
 What:		/sys/bus/coresight/devices/etm<N>/numvmidc
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates the number of VMID comparators that are available
+Description:	(Read) Indicates the number of VMID comparators that are available
 		for tracing.
 
 What:		/sys/bus/coresight/devices/etm<N>/nrseqstate
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates the number of sequencer states that are
+Description:	(Read) Indicates the number of sequencer states that are
 		implemented.
 
 What:		/sys/bus/coresight/devices/etm<N>/nr_resource
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates the number of resource selection pairs that are
+Description:	(Read) Indicates the number of resource selection pairs that are
 		available for tracing.
 
 What:		/sys/bus/coresight/devices/etm<N>/nr_ss_cmp
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates the number of single-shot comparator controls that
+Description:	(Read) Indicates the number of single-shot comparator controls that
 		are available for tracing.
 
 What:		/sys/bus/coresight/devices/etm<N>/reset
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(W) Cancels all configuration on a trace unit and set it back
+Description: 	(Write) Cancels all configuration on a trace unit and set it back
 		to its boot configuration.
 
 What:		/sys/bus/coresight/devices/etm<N>/mode
@@ -300,7 +300,7 @@ What:		/sys/bus/coresight/devices/etm<N>/addr_cmp_view
 Date:		December 2019
 KernelVersion:	5.5
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the current settings for the selected address
+Description:	(Read) Print the current settings for the selected address
 		comparator.
 
 What:		/sys/bus/coresight/devices/etm<N>/sshot_idx
@@ -319,7 +319,7 @@ What:		/sys/bus/coresight/devices/etm<N>/sshot_status
 Date:		December 2019
 KernelVersion:	5.5
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the current value of the selected single shot
+Description:	(Read) Print the current value of the selected single shot
 		status register.
 
 What:		/sys/bus/coresight/devices/etm<N>/sshot_pe_ctrl
@@ -333,111 +333,111 @@ What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcoslsr
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the OS Lock Status Register (0x304).
+Description:	(Read) Print the content of the OS Lock Status Register (0x304).
 		The value it taken directly  from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcpdcr
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the Power Down Control Register
+Description:	(Read) Print the content of the Power Down Control Register
 		(0x310).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcpdsr
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the Power Down Status Register
+Description:	(Read) Print the content of the Power Down Status Register
 		(0x314).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trclsr
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the SW Lock Status Register
+Description:	(Read) Print the content of the SW Lock Status Register
 		(0xFB4).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcauthstatus
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the Authentication Status Register
+Description:	(Read) Print the content of the Authentication Status Register
 		(0xFB8).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcdevid
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the Device ID Register
+Description:	(Read) Print the content of the Device ID Register
 		(0xFC8).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcdevtype
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the Device Type Register
+Description:	(Read) Print the content of the Device Type Register
 		(0xFCC).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcpidr0
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the Peripheral ID0 Register
+Description:	(Read) Print the content of the Peripheral ID0 Register
 		(0xFE0).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcpidr1
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the Peripheral ID1 Register
+Description:	(Read) Print the content of the Peripheral ID1 Register
 		(0xFE4).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcpidr2
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the Peripheral ID2 Register
+Description:	(Read) Print the content of the Peripheral ID2 Register
 		(0xFE8).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcpidr3
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the Peripheral ID3 Register
+Description:	(Read) Print the content of the Peripheral ID3 Register
 		(0xFEC).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcconfig
 Date:		February 2016
 KernelVersion:	4.07
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the trace configuration register
+Description:	(Read) Print the content of the trace configuration register
 		(0x010) as currently set by SW.
 
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trctraceid
 Date:		February 2016
 KernelVersion:	4.07
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Print the content of the trace ID register (0x040).
+Description:	(Read) Print the content of the trace ID register (0x040).
 
 What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr0
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the tracing capabilities of the trace unit (0x1E0).
+Description:	(Read) Returns the tracing capabilities of the trace unit (0x1E0).
 		The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr1
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the tracing capabilities of the trace unit (0x1E4).
+Description:	(Read) Returns the tracing capabilities of the trace unit (0x1E4).
 		The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr2
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the maximum size of the data value, data address,
+Description:	(Read) Returns the maximum size of the data value, data address,
 		VMID, context ID and instuction address in the trace unit
 		(0x1E8).  The value is taken directly from the HW.
 
@@ -445,7 +445,7 @@ What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr3
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the value associated with various resources
+Description:	(Read) Returns the value associated with various resources
 		available to the trace unit.  See the Trace Macrocell
 		architecture specification for more details (0x1E8).
 		The value is taken directly from the HW.
@@ -454,42 +454,42 @@ What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr4
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns how many resources the trace unit supports (0x1F0).
+Description:	(Read) Returns how many resources the trace unit supports (0x1F0).
 		The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr5
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns how many resources the trace unit supports (0x1F4).
+Description:	(Read) Returns how many resources the trace unit supports (0x1F4).
 		The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr8
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the maximum speculation depth of the instruction
+Description:	(Read) Returns the maximum speculation depth of the instruction
 		trace stream. (0x180).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr9
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the number of P0 right-hand keys that the trace unit
+Description:	(Read) Returns the number of P0 right-hand keys that the trace unit
 		can use (0x184).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr10
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the number of P1 right-hand keys that the trace unit
+Description:	(Read) Returns the number of P1 right-hand keys that the trace unit
 		can use (0x188).  The value is taken directly from the HW.
 
 What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr11
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the number of special P1 right-hand keys that the
+Description:	(Read) Returns the number of special P1 right-hand keys that the
 		trace unit can use (0x18C).  The value is taken directly from
 		the HW.
 
@@ -497,7 +497,7 @@ What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr12
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the number of conditional P1 right-hand keys that
+Description:	(Read) Returns the number of conditional P1 right-hand keys that
 		the trace unit can use (0x190).  The value is taken directly
 		from the HW.
 
@@ -505,6 +505,6 @@ What:		/sys/bus/coresight/devices/etm<N>/trcidr/trcidr13
 Date:		April 2015
 KernelVersion:	4.01
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Returns the number of special conditional P1 right-hand keys
+Description:	(Read) Returns the number of special conditional P1 right-hand keys
 		that the trace unit can use (0x194).  The value is taken
 		directly from the HW.
diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
index 1dffabe7f48d..53e1f4815d64 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
@@ -42,7 +42,7 @@ What:		/sys/bus/coresight/devices/<memory_map>.stm/status
 Date:		April 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) List various control and status registers.  The specific
+Description:	(Read) List various control and status registers.  The specific
 		layout and content is driver specific.
 
 What:		/sys/bus/coresight/devices/<memory_map>.stm/traceid
diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index ab49b9ac3bcb..6aa527296c71 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -11,21 +11,21 @@ What:           /sys/bus/coresight/devices/<memory_map>.tmc/mgmt/rsz
 Date:           March 2016
 KernelVersion:  4.7
 Contact:        Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:    (R) Defines the size, in 32-bit words, of the local RAM buffer.
+Description:    (Read) Defines the size, in 32-bit words, of the local RAM buffer.
                 The value is read directly from HW register RSZ, 0x004.
 
 What:           /sys/bus/coresight/devices/<memory_map>.tmc/mgmt/sts
 Date:           March 2016
 KernelVersion:  4.7
 Contact:        Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the TMC status register.  The value
+Description:	(Read) Shows the value held by the TMC status register.  The value
                 is read directly from HW register STS, 0x00C.
 
 What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/rrp
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the TMC RAM Read Pointer register
+Description:	(Read) Shows the value held by the TMC RAM Read Pointer register
 		that is used to read entries from the Trace RAM over the APB
 		interface.  The value is read directly from HW register RRP,
 		0x014.
@@ -34,7 +34,7 @@ What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/rwp
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the TMC RAM Write Pointer register
+Description:	(Read) Shows the value held by the TMC RAM Write Pointer register
 		that is used to sets the write pointer to write entries from
 		the CoreSight bus into the Trace RAM. The value is read directly
 		from HW register RWP, 0x018.
@@ -43,21 +43,21 @@ What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/trg
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Similar to "trigger_cntr" above except that this value is
+Description:	(Read) Similar to "trigger_cntr" above except that this value is
 		read directly from HW register TRG, 0x01C.
 
 What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/ctl
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the TMC Control register. The value
+Description:	(Read) Shows the value held by the TMC Control register. The value
 		is read directly from HW register CTL, 0x020.
 
 What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/ffsr
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the TMC Formatter and Flush Status
+Description:	(Read) Shows the value held by the TMC Formatter and Flush Status
 		register.  The value is read directly from HW register FFSR,
 		0x300.
 
@@ -65,7 +65,7 @@ What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/ffcr
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the TMC Formatter and Flush Control
+Description:	(Read) Shows the value held by the TMC Formatter and Flush Control
 		register.  The value is read directly from HW register FFCR,
 		0x304.
 
@@ -73,7 +73,7 @@ What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/mode
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Shows the value held by the TMC Mode register, which
+Description:	(Read) Shows the value held by the TMC Mode register, which
 		indicate the mode the device has been configured to enact.  The
 		The value is read directly from the MODE register, 0x028.
 
@@ -81,7 +81,7 @@ What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/devid
 Date:		March 2016
 KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) Indicates the capabilities of the Coresight TMC.
+Description:	(Read) Indicates the capabilities of the Coresight TMC.
 		The value is read directly from the DEVID register, 0xFC8,
 
 What:		/sys/bus/coresight/devices/<memory_map>.tmc/buffer_size
diff --git a/Documentation/ABI/testing/sysfs-bus-moxtet-devices b/Documentation/ABI/testing/sysfs-bus-moxtet-devices
index 355958527fa3..4a6d61b44f3f 100644
--- a/Documentation/ABI/testing/sysfs-bus-moxtet-devices
+++ b/Documentation/ABI/testing/sysfs-bus-moxtet-devices
@@ -2,16 +2,16 @@ What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_description
 Date:		March 2019
 KernelVersion:	5.3
 Contact:	Marek Behún <marek.behun@nic.cz>
-Description:	(R) Moxtet module description. Format: string
+Description:	(Read) Moxtet module description. Format: string
 
 What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_id
 Date:		March 2019
 KernelVersion:	5.3
 Contact:	Marek Behún <marek.behun@nic.cz>
-Description:	(R) Moxtet module ID. Format: %x
+Description:	(Read) Moxtet module ID. Format: %x
 
 What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_name
 Date:		March 2019
 KernelVersion:	5.3
 Contact:	Marek Behún <marek.behun@nic.cz>
-Description:	(R) Moxtet module name. Format: string
+Description:	(Read) Moxtet module name. Format: string
diff --git a/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm b/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
index 15595fab88d1..b8631f5a29c4 100644
--- a/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
+++ b/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
@@ -2,21 +2,21 @@ What:		/sys/firmware/turris-mox-rwtm/board_version
 Date:		August 2019
 KernelVersion:	5.4
 Contact:	Marek Behún <marek.behun@nic.cz>
-Description:	(R) Board version burned into eFuses of this Turris Mox board.
+Description:	(Read) Board version burned into eFuses of this Turris Mox board.
 		Format: %i
 
 What:		/sys/firmware/turris-mox-rwtm/mac_address*
 Date:		August 2019
 KernelVersion:	5.4
 Contact:	Marek Behún <marek.behun@nic.cz>
-Description:	(R) MAC addresses burned into eFuses of this Turris Mox board.
+Description:	(Read) MAC addresses burned into eFuses of this Turris Mox board.
 		Format: %pM
 
 What:		/sys/firmware/turris-mox-rwtm/pubkey
 Date:		August 2019
 KernelVersion:	5.4
 Contact:	Marek Behún <marek.behun@nic.cz>
-Description:	(R) ECDSA public key (in pubkey hex compressed form) computed
+Description:	(Read) ECDSA public key (in pubkey hex compressed form) computed
 		as pair to the ECDSA private key burned into eFuses of this
 		Turris Mox Board.
 		Format: string
@@ -25,7 +25,7 @@ What:		/sys/firmware/turris-mox-rwtm/ram_size
 Date:		August 2019
 KernelVersion:	5.4
 Contact:	Marek Behún <marek.behun@nic.cz>
-Description:	(R) RAM size in MiB of this Turris Mox board as was detected
+Description:	(Read) RAM size in MiB of this Turris Mox board as was detected
 		during manufacturing and burned into eFuses. Can be 512 or 1024.
 		Format: %i
 
@@ -33,5 +33,5 @@ What:		/sys/firmware/turris-mox-rwtm/serial_number
 Date:		August 2019
 KernelVersion:	5.4
 Contact:	Marek Behún <marek.behun@nic.cz>
-Description:	(R) Serial number burned into eFuses of this Turris Mox device.
+Description:	(Read) Serial number burned into eFuses of this Turris Mox device.
 		Format: %016X
-- 
2.26.2

