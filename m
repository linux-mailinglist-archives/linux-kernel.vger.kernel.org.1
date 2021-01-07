Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1E02ECF61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbhAGMPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:15:20 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51005 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbhAGMPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:15:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B1285C01D3;
        Thu,  7 Jan 2021 07:14:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 Jan 2021 07:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=4vWBOyewXPRbnL0vh4DvmtPzWrs
        iIMR6b5Es7JbZrp4=; b=gv7qiYOTBOnF1/wRcLgmcgsuCuJqcd8N6U/R/ugmcLk
        WdRd03k7UBZkH3m/Rt/KFKdKomx4coGqWE39um57IN8fdmQ+faqjJB/R9P1BnDps
        yzcUU/aKTNU0m+c6/AS0Rgsdk9hnjquHOAOhV8rYv2zlxmoRPQ6Tqt0aj/8VDFHI
        8Fc3n6Ps32yz/wXxx8pEYcA6y+HydS4/hP8CTjVrOma1Ol30KYma7UNkXd7JrW88
        5MnEBlxgC48c4B60hR9ulKID/RLt02FZXUgfugkAb70bHheLCWsSyMBovKMbzXan
        KZmmxN/h0Nmn4yjISlheLuJFekBbJ6ihnnybJGjG5Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4vWBOy
        ewXPRbnL0vh4DvmtPzWrsiIMR6b5Es7JbZrp4=; b=e84UIHDgUHcPSNWjT4Y0dE
        wdaFLIB8j7PzvAZ0qhI5XZay3zHck6fs5GqaGhQqcMObpEbnQ2rckpBFwht37LMA
        cy+aQdaIrKCPXnarpjFQzSnJSyotXf5VSdgXlEeUKfX3dGxpOGMe8MvO+JtLgQTZ
        2f8akvValXt8CCWhS1Ug8bcO9KXCRUClUXFnQBLu2LJPR3KOQHt9g6mYt1IZWgrF
        HsykHbgGKuX/Y65k3fX6sbPFutrHdZiaGmBMrNQq2zHugbCbGBX2MT2Kh7oT4K9Z
        iTAiCBCCkQ+sjSydKSVQrJV6m/fm9Uz8y3ca7caw4fxKsWdVfeRqgPx3+SuRTYPg
        ==
X-ME-Sender: <xms:Kfv2XxEsRXcna5IBKcEI-BgApWb5dFNhNo_rzKZzyoBpexXwPk1zZw>
    <xme:Kfv2X2UlrZMw3_IOJ4Fldm84OyqMMgXE--ASJGDo2ZBTufDFccAsK2J2Jgt1AK7Qy
    xNL9iR9Ajg8Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfghhrvghg
    sehkrhhorghhrdgtohhmfdcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrth
    htvghrnhepiefgleegleejueehleffhfeuueekvdegfedtjeeigefgleehtdefudfgveeh
    vdevnecuffhomhgrihhnpehsphhinhhitghsrdhnvghtnecukfhppeekfedrkeeirdejge
    drieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Kfv2XzICznZtRPXfCewGBBODexbeXqCh4r1SCFmIF-ji1JEUfaNPWw>
    <xmx:Kfv2X3FHq1LXbF_Z1TCSU6DT4hGygfZitteXEsB8Z3hjEstD3fZ5mQ>
    <xmx:Kfv2X3W1jCtpQWU-_7ccU_Eqro5yZ4iCjEUlhCxtgmTrs2xS28d6TQ>
    <xmx:Kfv2X-C_6CWMiHkv03PERaAOvxqI1xr8xhHH3PqTMmDNa77O6PiYXA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id C2DCF24005D;
        Thu,  7 Jan 2021 07:14:32 -0500 (EST)
Date:   Thu, 7 Jan 2021 13:15:53 +0100
From:   "greg@kroah.com" <greg@kroah.com>
To:     Partha Nayak <partha.nayak@nutanix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.19 07/29] ext4: dont remount read-only with
 errors=continue on reboot
Message-ID: <X/b7eY6izK+MIht+@kroah.com>
References: <BYAPR02MB4759194730E06BCDC10892AC88AF0@BYAPR02MB4759.namprd02.prod.outlook.com>
 <BYAPR02MB4759ADB966DDEAAE42B11EAA88AF0@BYAPR02MB4759.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB4759ADB966DDEAAE42B11EAA88AF0@BYAPR02MB4759.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:39:14AM +0000, Partha Nayak wrote:
> Hi Greg / Linux community
> 
> I was going through the patch details: https://www.spinics.net/lists/stable/msg436529.html .
> 
> In our case the superblock for EXT4 is configured to trigger a kernel panic . But inspite of that the file system was mounted as read-only . We are on 4.19.12 .

4.19.12 is _VERY_ old and obsolete and totally insecure and is not
supported by the community, it was released over two years ago.

Why not apply the patch you link here and see if it solves your issue?

Or, better yet, move to 4.19.165, or 5.10.y?  What prevents you from
doing that?

good luck!

greg k-h
