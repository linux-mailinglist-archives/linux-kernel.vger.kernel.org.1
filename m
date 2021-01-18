Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA52FA11C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404354AbhARNRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:17:31 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13953 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391494AbhARNRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:17:14 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60058a220000>; Mon, 18 Jan 2021 05:16:18 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 18 Jan 2021 13:16:11 +0000
Date:   Mon, 18 Jan 2021 15:16:08 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
CC:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        <daniel.vetter@ffwll.ch>, <sam@ravnborg.org>,
        <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        <virtualization@lists.linux-foundation.org>
Subject: Re: Change eats memory on my server
Message-ID: <20210118131608.GA50817@mtl-vdi-166.wap.labs.mlnx>
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
 <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
 <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
 <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610975778; bh=l3l11JUxFpok5jfXeALrLtW4EEP/3cDQ3PHNG0KaDhY=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=jRrqMxhJ7q0y5UDTfh7isRbwgK1CaJpORosmdB/dQkPQaFgD/oUEY8jPFgDEeOVtT
         wdtvCaCdzFpjaKCfn+Gt+klO/xSrRBnSTiLYHQCJzJBh3K/SbVIl1etE9NSSt5grcJ
         iTDOGy0vmqj3aWfXVch/KFSnIK+l2b2amsODD/rHGTWrn8WciTIkmRUHps/eSZlT8I
         mj2L3J698a1juj4nwXSBg0+OUyhtQgXD0F0KU7lHfa/iRpMjYF/31gGQE45UUWMXFX
         kII/By6CXb5GkleFF4+sI+8p3CV26v39Uo7jp5UlHKgbTPR2Is7Fe4Or6givSx1Ax/
         T2wMkU8G23cog==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 10:30:56AM +0100, Thomas Zimmermann wrote:
> 
> Here's the patch against the latest DRM tree. v5.11-rc3 should work as well.
> 
> I was able to reproduce the memory leak locally and found that the patch
> fixes it. Please give it a try.
> 

As far as I am concerned, this issue is fixed by the patch you sent.

Thanks for looking into it.

Eli
