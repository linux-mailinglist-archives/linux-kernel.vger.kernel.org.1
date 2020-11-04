Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6F2A6694
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgKDOnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKDOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:43:08 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A685C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 06:43:08 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id b11so9986450qvr.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 06:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lmbi1/0VDYZUpNolZHV0TsFpm/9q4/Uw+B/uPoJrlVY=;
        b=BfBwDtnCcxDWkPdfm8AIsS4n+UUtDR/t4p42XN/JJFzdQn2Lf7S2ZuUTnmKyPc8P2Z
         Y7OtVFG9izBhNHs315tmQcVeo3ZCGJ72RWCrEA4uEdDTKkI7NnwPn+91teG44ncmJzRu
         UAjCi9G59US/IdAyfElgJf0aSUhXJj8NqFcksZIeaKU6CqRT6rCnsmDBmUF3xuqVOoKj
         tn5LcAkmRZP0U4o09FaRwWN3z60h6h9elN3NrFtbaHSdXV3DeS3/LZrdEDVKrcSh1aYA
         bys+0KC7oXHLsM2QROwoSG+809O90GWVL55dVCfD9qIheDgjuXpAFF1H4nEDpby7Ln7F
         tM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmbi1/0VDYZUpNolZHV0TsFpm/9q4/Uw+B/uPoJrlVY=;
        b=nsfi/b8NDU+gNF0bNqAa3jmpClMmeTAG4DxsAF+UkDYesNyp3hXOdJ2aW0Ux1yTRBK
         LvqJaBnpiTfT1JS0+bm4avXbV5qeBJF99Kf5UKUMpJdHivh86Fj8Y6mTSlgKmE3Ij0Si
         F+o+qe1KHaEI9cJ+omX41oL1OZM8kZ4b7Boi4shW5MJvQYnOpEG+PC/MdBJpQJqFCnF5
         kd8nbJtsUNR35UbVGo0xpykJD8sl3yMp55gp66Xvjr3HpYB/nnXMCAQU5k2E3mQ7HhFh
         xOekF/1GfBCuLw0Wfk/sQCyJysGEyznWHxde/D5hAKXFMotClqC49LgwRmTgm4rHJa4N
         WCDA==
X-Gm-Message-State: AOAM531VrzwEVsn0tRu1pyG6GkNQkcITxe7w/CSAbhg8UwH/uX4M1ggk
        wz2BnUpVcN9djHAdAL8gLKM=
X-Google-Smtp-Source: ABdhPJz4/Wvt193vKJAPsxgSEwNh3xiIDRyZfnTkUP3icox+LgSKAxH+zFW6sva3j8vaqobNxWHi7g==
X-Received: by 2002:ad4:4142:: with SMTP id z2mr33756258qvp.20.1604500987457;
        Wed, 04 Nov 2020 06:43:07 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t70sm2404118qke.119.2020.11.04.06.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2020 06:43:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0386627C0054;
        Wed,  4 Nov 2020 09:43:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 04 Nov 2020 09:43:06 -0500
X-ME-Sender: <xms:-b2iXyODx8lLrgl70XkALuT5dYPSiUsYS38idj7GP46qsHzTm7hKYw>
    <xme:-b2iXw9k_q9PJOZX5K3R6kX-SYjaT-Gmzd6CmfrIpsdAKgBMmWfaRhXmmD-cMJAFo
    vO6r6qhWOvLovqqFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:-b2iX5RsarTwFe7tnFE2h4_GQv_rjV20Mq9BLUrovnwIgy4XA7nqmQ>
    <xmx:-b2iXyufMCRS0xo_XjWp3vHTk1jEYJ85IYuqI1OMQo06c-Bldhj89Q>
    <xmx:-b2iX6crnFngXrtXAyRNL_w5mR_zn-wZlXHFS-UrLBwOdpFP0wsUXA>
    <xmx:-r2iXwsQlZXEfV96FpBlgamtyHP5O8ErwFb6W0muYH_3K4pA17gzmQ>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD0C33064610;
        Wed,  4 Nov 2020 09:43:04 -0500 (EST)
Date:   Wed, 4 Nov 2020 22:42:09 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 05/16] rcu: De-offloading CB kthread
Message-ID: <20201104144209.GA2748545@boqun-archlinux>
References: <20201023144649.53046-1-frederic@kernel.org>
 <20201023144649.53046-6-frederic@kernel.org>
 <20201102133824.GA2661878@boqun-archlinux>
 <20201104143135.GB467220@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104143135.GB467220@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 03:31:35PM +0100, Frederic Weisbecker wrote:
[...]
> > 
> > > +	rcu_segcblist_offload(cblist, false);
> > > +	raw_spin_unlock_rcu_node(rnp);
> > > +
> > > +	if (rdp->nocb_cb_sleep) {
> > > +		rdp->nocb_cb_sleep = false;
> > > +		wake_cb = true;
> > > +	}
> > > +	rcu_nocb_unlock_irqrestore(rdp, flags);
> > > +
> > > +	if (wake_cb)
> > > +		swake_up_one(&rdp->nocb_cb_wq);
> > > +
> > > +	swait_event_exclusive(rdp->nocb_state_wq,
> > > +			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static long rcu_nocb_rdp_deoffload(void *arg)
> > > +{
> > > +	struct rcu_data *rdp = arg;
> > > +
> > > +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> > 
> > I think this warning can actually happen, if I understand how workqueue
> > works correctly. Consider that the corresponding cpu gets offlined right
> > after the rcu_nocb_cpu_deoffloaed(), and the workqueue of that cpu
> > becomes unbound, and IIUC, workqueues don't do migration during
> > cpu-offlining, which means the worker can be scheduled to other CPUs,
> > and the work gets executed on another cpu. Am I missing something here?.
> 
> We are holding cpus_read_lock() in rcu_nocb_cpu_offload(), this should
> prevent from that.
> 

But what if the work doesn't get executed until we cpus_read_unlock()
and someone offlines that CPU?

Regards,
Boqun

> Thanks!
