Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21129FC19
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgJ3DTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:19:02 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56623 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgJ3DTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:19:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C1B55C00D8;
        Thu, 29 Oct 2020 23:19:01 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 29 Oct 2020 23:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=g1UFE2VfgvZHci7NuTUW5H0p/65rAXn
        S0ZULATTBK7k=; b=QuKE+qlfoPG3NTEYdxDMseJK/N0tt4z/T/NQD75of7L7Zuv
        5CdKrsrlX8zHdm2HM//x6ARWBPBSXrWmevcCtePQz1/xMVVm7CPp/o+pscpXO1L9
        8e0/L+mNmU8s+uvwGnVudRY6mKr1Ea+TLaVWmiyFFZOUDq5pvi5LILaaxkl/kmxb
        uxxCtDyC4J5SIoSre5XAae2cGmQWLL4/89o1kD5IUcFzDDi159Ldcr1slv9Er25d
        Ef6/Yb9yI8nJQdBuVu77V3zZd6XycYN/C4VlEblUOYJ93jzcWjBFrnTcG+K++aVM
        Flt7/NA/3QiASnH1zrKEXNQQcrYd2+ci8UnnkGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=g1UFE2
        VfgvZHci7NuTUW5H0p/65rAXnS0ZULATTBK7k=; b=KE+i01IM6OxLV2I2Hrfqk7
        LrrP9R1GiEAa1x3JwbmSASqlBvNkigPxUc1Bg68QXXey4GpTiqNcxL4666gPVZ6m
        0v9Ljmzx6xxmkdgMp6AW+XiJm9IrvKnikZUqIsBT/7PD3QPzEud//ZkrYh1cdvvg
        lhUsoy/HLUMVU6B87b83qR8vF/01gQlN2IUVUQS2rRGIQ5ykhlSm6d24vEt7TZMV
        kgNicwUoFow7RSCz9X8qP1JbMfX/UJNFJj5O4yp0lR9c+y1PoiimPNghwLt2ynDY
        18SqD17Bhs7/GbFPbiGFheQcD73DfuDQMYAW+0OBmA2XmzKBdmNd/DET1IVt+kmQ
        ==
X-ME-Sender: <xms:IYabX0BEj2z_ZcpK6fzuV4U3sYLaqLt7gUmJ8af_yftckVVUkTh5fA>
    <xme:IYabX2irR6OH42WrMaxTXw9bywxNcaWKNJ-TdreYpM0SFkhzlQV7SZ4_umeHoNOLw
    ys_pXdJuCV9UzAvEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpedutddtkeeugeegvddttdeukeeiuddtgfeuuddtfeeiueetfeeileettedv
    tdfhieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:IYabX3nDwxSBj4Yicc-WLio1U5kpsesVMsqgvDoua3elByElxoHuwA>
    <xmx:IYabX6xcaB8zGSG-eNQpl4NcBBFrIEyBfvpOdxQBdWtxBgw5GyWj3g>
    <xmx:IYabX5TBhfUdcQmdxjpSWuY13HKasHxinSmClhxYbHuRXqrnAq5z1Q>
    <xmx:JYabXyLufK38dbWko70d-k2ezGZMu9Lfo_08PD4Bc44wgGtDrNxcgA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 16AE6E00AF; Thu, 29 Oct 2020 23:18:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-530-g8da6958-fm-20201021.003-g69105b13-v35
Mime-Version: 1.0
Message-Id: <c3b4c7d8-65fc-4196-b635-bf65ed3b44a1@www.fastmail.com>
In-Reply-To: <20201029062723.20798-1-dylan_hung@aspeedtech.com>
References: <20201029062723.20798-1-dylan_hung@aspeedtech.com>
Date:   Fri, 30 Oct 2020 13:48:36 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Dylan Hung" <dylan_hung@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com
Subject: =?UTF-8?Q?Re:_[PATCH]_ARM:_dts:_aspeed-g6:_Fix_HVI3C_function-group_in_p?=
 =?UTF-8?Q?inctrl_dtsi?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Oct 2020, at 16:57, Dylan Hung wrote:
> The HVI3C shall be a group of I3C function, not an independent function.
> Correct the function name from "HVI3C" to "I3C".
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Good catch. Thanks Dylan.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
