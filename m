Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C619C2E92CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbhADJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:49:31 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38543 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbhADJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:49:29 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B6E865C0057;
        Mon,  4 Jan 2021 04:48:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Jan 2021 04:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=F
        qdO1gdt13IjtRqkyTaTRzNxnMeL+xdp7/4ZEWGgl5I=; b=LVMTGUDP5xKb63fJW
        2xILFVN68yZi8AhHPfANMtIEgPKLnzP3XJnHCcdIrJwTsyvL1MV1KoQhtQofuzH2
        3tBIY9VaFXmqiQzS2rKJu2b4QhBHOyZPVgXAviyxgHW22YEoxXwhoAz6VpOlG6TR
        GSLZLykIp275OBEP5V/c0NAYZIHZYw25qSCna0uwei5idzMZvzF5s5ItWIsHpWYu
        KJveAS2oqgFWBiE9w4s9iwfH0SfzJJYe+PCkDxC+hmcLWOrVdgkEawd8ZUtqFRs/
        mMPOXvCowuhJNUYIfIR+4XlM2CiFIaFbwcKl9gv7M7XbOiQyLknfTcKCfTL3VhIi
        /p5Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=FqdO1gdt13IjtRqkyTaTRzNxnMeL+xdp7/4ZEWGgl
        5I=; b=JNm+M5EgKvANkSq+ghIZhGqGpn1oJlJq62IkWS+rp2Ci6MDEufKw4Fe4H
        n2Mf3X00ANLztHW3SJ3cRu04MXXwrTWShv8w4zfelG34CqTimE/F6QQ21GtmNkhm
        FdBY+TjJA07JM8iGJlgLWlazqM/DBckd5qtq/9Z+CKudlCWUeycHndovppNiZgxy
        r1GyL27V9JOKStlhbnMKTO+r774tILvvMoNw6itfHE5fLTWvpnBgT5c+6mfSUwfw
        7aDf9I3GFc3sDZAJadqLLRFwRcRm80FU6crS5tq7BSo6RkRuCue9dKPtIX8Z+2KO
        RjcdKRMD4NMailcZ5atiZ7x1G4BLQ==
X-ME-Sender: <xms:ZuTyX_yUtGjdEn7tZ9UeaC6TBgsucnKRCddhOVFFD_kNdh_wz7syLA>
    <xme:ZuTyX3TzA_sKca9BgjAuvt_Moc7XiuGTJa_8iVGDXfDLW8jVMchtGC7H72wBo5DzP
    y1y0gIK2gLobA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeffedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeegieejuedvffeuvdfftdetfeeuhfekhefgueffjeevte
    dtlefgueduffffteeftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:ZuTyX5U4uWsXqnkqqpkjiL8e_HEKPPcgBVDRwHcb0J2-TithXlYwfg>
    <xmx:ZuTyX5hh8uoKvWqE7fB9m1kQ39Vk9-7NaDaHs9gMa-qh7qNW1x3aCg>
    <xmx:ZuTyXxDiRdGasmnJkH3FxPLKII-Ex7WIxIEnViEWVWspZAoxIg8RGQ>
    <xmx:Z-TyXwNlVNk-IUiks3n7X8EFG2XwMbG_ehMIpmzPy8DXFuqHY0ZD1Q>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4292A1080066;
        Mon,  4 Jan 2021 04:48:22 -0500 (EST)
Date:   Mon, 4 Jan 2021 10:49:49 +0100
From:   Greg KH <greg@kroah.com>
To:     "chensong_2000@189.cn" <chensong_2000@189.cn>
Cc:     linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        sfr@canb.auug.org.au, abbotti@mev.co.uk,
        hsweeten@visionengravers.com
Subject: Re: [PATCH v2] staging: board: Remove macro board_staging
Message-ID: <X/LkvTaT4+AV+tov@kroah.com>
References: <1609750546-17118-1-git-send-email-chensong_2000@189.cn>
 <X/LauHVX4EPvuzU4@kroah.com>
 <267d48f8-395f-c14b-b166-e2e6c5a5be44@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <267d48f8-395f-c14b-b166-e2e6c5a5be44@189.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 05:17:52PM +0800, chensong_2000@189.cn wrote:
> 
> 
> 在 2021/1/4 下午5:07, Greg KH 写道:
> > On Mon, Jan 04, 2021 at 04:55:46PM +0800, Song Chen wrote:
> > > Macro is not supposed to have flow control in it's
> > > statement, remove.
> > > 
> > > Signed-off-by: Song Chen <chensong_2000@189.cn>
> > > 
> > > ---
> > > Changes in v2:
> > > 1, kzm9d_init and armadillo800eva_init are not compatible
> > > with the definition of device_initcall, fixed.
> > 
> > I already applied v1, so what am I supposed to do here?
> 
> In https://lore.kernel.org/lkml/20170220175506.GA30142@kroah.com/, it
> seems that kernel can live with the checkpatch warning messages of "Macro is
> not supposed to have flow control in it's statement" in
> driver/staging/board. If so, please drop the patch.

I'm confused, maybe I didn't apply the first patch?  Am I confusing this
with a different patch for this code?

greg "I need more coffee..." k-h
