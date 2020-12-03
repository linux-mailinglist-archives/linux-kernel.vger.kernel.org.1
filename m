Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054572CD9D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbgLCPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:08:16 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55113 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbgLCPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:08:15 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A6BE5C0184;
        Thu,  3 Dec 2020 10:07:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Dec 2020 10:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=qjmrN0EMSMkCmVySFWGLotHkKSP
        KAsJveSwCM7F6yRc=; b=ReF171xAodVbvadX9n4Zy788Arxmf0LddxLFy9FHigt
        Zc0ADz6952zMEaY0NOyEiGF6HydQb+RxYUWijQr6NGMjIb2rYbEhYtaOWoNnmQBw
        pDwq/sXmW/MSdY8ceaFlakvBmmdf+rGEJj8eORzDehyxUauzMT4MHKwaovwdtQpq
        eCy3QmZlcGJ/n+N5nT5Qu97CsNH/nJsOYIYwmr8gvDKlREpej+7VCp5JbK411CUZ
        MzSpm6OE0pP98V07HJFRfJ4qKk8EbVaGd2cN/q5fz07uCrssnVf+px4ZgC0fV+ZO
        fId1GUrrv8NKnuIPwoZFaszoXkpL3D9+IL/8zZp1DVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qjmrN0
        EMSMkCmVySFWGLotHkKSPKAsJveSwCM7F6yRc=; b=m7knTswj5Z0E/lvAOxkSO+
        7SF30E0R9QOweFPVnCS4valu/zcSkhFwUuaMiJbSOs+ZJ5EU5ZgEXC16a1Pg3H+J
        Td5EU+bGsrvniBA86GTML8duFW5oK9LuFv+sTGUi9b60QHhdBo6+RbhJ4/GMxPR2
        837JLHVvJbwbQNnpyKYqhKj1JLJXJvo+uAG4J0PAlBUD4BEbQkdfDQgufsj+JXHx
        LmxPrBTsaQOCy22FWwHSacon1Ul9QEnkAbrEYIT/apD6bdPVE5jXDEpnvFGeYqsE
        ec1pXEiBggK2R19/QZ61a9NtW94eBIzskUwa3/aNYJwcm4kiIEFjmSrqZhvbVsyw
        ==
X-ME-Sender: <xms:HP_IX9sxE4cTgNexyNZCe0hmN2up4m-cjr9G-8PNxhY3zh64bENELw>
    <xme:HP_IX2Z9UAo7-E4Aby0Ojgl_nHuokak4ijsWN2JYyYVdxTr7t_2EKPLFcs3DgB14R
    rgDLqs7mRIdhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeiiedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:HP_IX9r9G2RfcPyR6PI5bx9aX39nPFEsU-D2VwPMgnelvzee8KuJtQ>
    <xmx:HP_IX7_en5jd2FPgztq6jEFBmcFTIuXYOT0mGRl1_Eglc1DZD_Vgtw>
    <xmx:HP_IX896RKcUMEQJVWA367wpLEoFyi2JK92x7JypymNcqGClhTJeeA>
    <xmx:HP_IX8dfLNrkCTzeXJYuCU7KYQ3zTcuuIcLWvvskGIcBnZgBmxkAfA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB4F224005D;
        Thu,  3 Dec 2020 10:07:07 -0500 (EST)
Date:   Thu, 3 Dec 2020 16:08:16 +0100
From:   Greg KH <greg@kroah.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] drivers: usb: core: prefer pr_*() macros over bare
 printk()
Message-ID: <X8j/YHJwhpOs9hPC@kroah.com>
References: <20201203142132.30334-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203142132.30334-1-info@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 03:21:32PM +0100, Enrico Weigelt, metux IT consult wrote:
> pr_*() printing helpers are preferred over using bare printk().

Sure, but that's not what you are doing here in this patch :(

Please fix up and resend.

greg k-h
