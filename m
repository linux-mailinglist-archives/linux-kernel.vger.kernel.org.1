Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3F24B1A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 11:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHTJEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 05:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgHTJEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:04:45 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D652078B;
        Thu, 20 Aug 2020 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597914284;
        bh=44LPzlmFBOIyCh0BkVIkys/ibH3hQxYtoLkTqsFyeGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yJNS0t5KpBVawcDs1ud1B3UQlNu9K/mTz+NCHtNFf/OpfMymD5BUwApgRSl7BdGyW
         E1tcMS0UrPc5RyT2UtYhdP+pwQnCg3+nE/tbwZhGDBFyU56DVvJdFC3TPWaIsdcsDY
         lBbQJcG5PRKkU7iEc3wbYtOS5pnab6p4LKuBhZ4Q=
Date:   Thu, 20 Aug 2020 11:04:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>
Subject: Re: [PATCH 1/3] drm: hikey9xx: Fix inconsistent compat string
Message-ID: <20200820110440.6b09bf8e@coco.lan>
In-Reply-To: <20200820033939.127932-1-john.stultz@linaro.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
        <20200820033939.127932-1-john.stultz@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 20 Aug 2020 03:39:39 +0000
John Stultz <john.stultz@linaro.org> escreveu:

> This is against Mauro's tree here:
> https://gitlab.freedesktop.org/mchehab_kernel/hikey-970/-/commits/master/
> 
> A previous patch changed this string to be
> "hisilicon,kirin960-dpe", but there are other place where the
> code still expects "hisilicon,hi3660-dpe", so change it back.

All 4 patches applied fine, and didn't cause any bad side effects
for Hikey 970.

So, I'll add them to my series. Thanks!

Thanks,
Mauro
