Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F8126B828
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgIPAhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:37:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:62772 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgIONYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:24:02 -0400
IronPort-SDR: 91aTZ9OSQwXV3vOOzbVkkVzUpg+iAaBPCRNScTC7FuWa7jokieqfEf/BOuTc6yVCkX5kQFqxp4
 C7VGizxxEKrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146997036"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="146997036"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:20:09 -0700
IronPort-SDR: Isx70hkPNJ0JgqVtz320eNI766rbex8guIQzHolgCfFR6Ew1suJGe6HoW1cDHbkX3lSf7TWEEy
 QuwbfpaPO4zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="409199755"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 06:20:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 16:20:06 +0300
Date:   Tue, 15 Sep 2020 16:20:06 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/14] usb: typec: tcpm: Add support for Sink Fast
 Role SWAP(FRS)
Message-ID: <20200915132006.GH1139641@kuha.fi.intel.com>
References: <20200901025927.3596190-1-badhri@google.com>
 <20200901025927.3596190-10-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-10-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:22PM -0700, Badhri Jagan Sridharan wrote:
> PD 3.0 spec defines a new mechanism for power role swap called
> Fast role swap. This change enables TCPM to support FRS when
> acting as sink.
> 
> Once the explicit contract is negotiated, sink port is
> expected to query the source port for sink caps to
> determine whether the source is FRS capable.
> Bits 23 & 24 of fixed pdo of the sink caps from the source, when
> set, indicates the current needed by the source when fast role
> swap is in progress(Implicit contract phasae). 0 indicates that
> the source does not support Fast Role Swap.
> 
> Upon receiving the FRS signal from the source,
> TCPC(TCPM_FRS_EVENT) informs TCPM to start the Fast role swap sequence.
> 
> 1. TCPM sends FRS PD message: FR_SWAP_SEND
> 2. If response is not received within the expiry of
>    SenderResponseTimer, Error recovery is triggered.:
>    FR_SWAP_SEND_TIMEOUT
> 3. Upon receipt of the accept message, TCPM waits for
>    PSSourceOffTimer for PS_READY message from the partner:
>    FR_SWAP_SNK_SRC_NEW_SINK_READY.
> 
> TCPC is expected to autonomously turn on vbus once the FRS
> signal is received and vbus voltage falls below vsafe5v within
> tSrcFrSwap. This is different from traditional power role swap
> where the vbus sourcing is turned on by TCPM.
> 
> 4. By this time, TCPC most likely would have started to
>    source vbus, TCPM waits for tSrcFrSwap to see  if the
>    lower level TCPC driver signals TCPM_SOURCING_VBUS event:
>    FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED.
> 5. When TCPC signals sourcing vbus, TCPM sends PS_READY msg and
>    changes the CC pin from Rd to Rp. This is the end of fast
>    role swap sequence and TCPM initiates the sequnce to negotiate
>    explicit contract by transitioning into SRC_STARTUP after
>    SwapSrcStart.
> 
> The code is written based on the sequence described in "Figure 8-107:
> Dual-role Port in Sink to Source Fast Role Swap State Diagram" of
> USB Power Delivery Specification Revision 3.0, Version 1.2.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> - Rebased on top of usb-next and resolved conflicts due to the below
>   changes:
>   3ed8e1c2ac99 usb: typec: tcpm: Migrate workqueue to RT priority for processing events
>   6bbe2a90a0bb usb: typec: tcpm: During PR_SWAP, source caps should be sent only after tSwapSourceStart
> - enable_frs sequence is now run as part of the same kthread that runs
>   the state machines.
> - Fixed the implicit fallthrough warning in the switch case for
>   FR_SWAP_CANCEL case.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 217 +++++++++++++++++++++++++++++++++-
>  include/linux/usb/pd.h        |  19 +--
>  include/linux/usb/tcpm.h      |   8 +-
>  include/linux/usb/typec.h     |  13 ++
>  4 files changed, 245 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 92806547f485..083e7af107b2 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -106,6 +106,13 @@
>  	S(VCONN_SWAP_TURN_ON_VCONN),		\
>  	S(VCONN_SWAP_TURN_OFF_VCONN),		\
>  						\
> +	S(FR_SWAP_SEND),			\
> +	S(FR_SWAP_SEND_TIMEOUT),		\
> +	S(FR_SWAP_SNK_SRC_TRANSITION_TO_OFF),			\
> +	S(FR_SWAP_SNK_SRC_NEW_SINK_READY),		\
> +	S(FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED),	\
> +	S(FR_SWAP_CANCEL),			\
> +						\
>  	S(SNK_TRY),				\
>  	S(SNK_TRY_WAIT),			\
>  	S(SNK_TRY_WAIT_DEBOUNCE),               \
> @@ -127,6 +134,9 @@
>  	S(GET_PPS_STATUS_SEND),			\
>  	S(GET_PPS_STATUS_SEND_TIMEOUT),		\
>  						\
> +	S(GET_SINK_CAP),			\
> +	S(GET_SINK_CAP_TIMEOUT),		\
> +						\
>  	S(ERROR_RECOVERY),			\
>  	S(PORT_RESET),				\
>  	S(PORT_RESET_WAIT_OFF)
> @@ -175,6 +185,8 @@ enum adev_actions {
>  #define TCPM_CC_EVENT		BIT(0)
>  #define TCPM_VBUS_EVENT		BIT(1)
>  #define TCPM_RESET_EVENT	BIT(2)
> +#define TCPM_FRS_EVENT		BIT(3)
> +#define TCPM_SOURCING_VBUS	BIT(4)
>  
>  #define LOG_BUFFER_ENTRIES	1024
>  #define LOG_BUFFER_ENTRY_SIZE	128
> @@ -184,6 +196,8 @@ enum adev_actions {
>  #define SVID_DISCOVERY_MAX	16
>  #define ALTMODE_DISCOVERY_MAX	(SVID_DISCOVERY_MAX * MODE_DISCOVERY_MAX)
>  
> +#define GET_SINK_CAP_RETRY_MS	100
> +
>  struct pd_mode_data {
>  	int svid_index;		/* current SVID index		*/
>  	int nsvids;
> @@ -261,6 +275,8 @@ struct tcpm_port {
>  	struct kthread_work state_machine;
>  	struct hrtimer vdm_state_machine_timer;
>  	struct kthread_work vdm_state_machine;
> +	struct hrtimer enable_frs_timer;
> +	struct kthread_work enable_frs;
>  	bool state_machine_running;
>  
>  	struct completion tx_complete;
> @@ -335,6 +351,12 @@ struct tcpm_port {
>  	/* port belongs to a self powered device */
>  	bool self_powered;
>  
> +	/* FRS */
> +	enum frs_typec_current frs_current;

Do you use this member anywhere?

I can't see anywhere it being used, but I think you should use it
instead the one in port_caps.

> +	/* Sink caps have been queried */
> +	bool sink_cap_done;
> +
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dentry;
>  	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -940,6 +962,16 @@ static void mod_vdm_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
>  	}
>  }

<snip>

> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 9cb1bec94b71..2ec7451a14ab 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -204,6 +204,18 @@ struct typec_operations {
>  			     enum typec_port_type type);
>  };
>  
> +/*
> + * Initial current capability of the new source when vSafe5V is applied during PD3.0 Fast Role Swap.
> + * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
> + * Version 1.2"
> + */
> +enum frs_typec_current {
> +	FRS_NOT_SUPPORTED,
> +	FRS_DEFAULT_POWER,
> +	FRS_5V_1P5A,
> +	FRS_5V_3A,
> +};
> +
>  /*
>   * struct typec_capability - USB Type-C Port Capabilities
>   * @type: Supported power role of the port
> @@ -226,6 +238,7 @@ struct typec_capability {
>  	int			prefer_role;
>  	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
>  	unsigned int		orientation_aware:1;
> +	enum frs_typec_current	frs_current;

So forget about this. We can add it here if/when there is another
driver that needs that. You already have that member in struct
tcpm_port, so just use that for now.

And you can also introduce enum frs_typec_current in tcpm.c for now.

>  	struct fwnode_handle	*fwnode;
>  	void			*driver_data;
> -- 
> 2.28.0.402.g5ffc5be6b7-goog

thanks,

-- 
heikki
