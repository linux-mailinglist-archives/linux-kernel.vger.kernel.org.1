Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AB5297DB4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 19:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762533AbgJXRPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 13:15:04 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:46594 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762526AbgJXRPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 13:15:03 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 539B820020;
        Sat, 24 Oct 2020 19:14:59 +0200 (CEST)
Date:   Sat, 24 Oct 2020 19:14:57 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bernard <bernard@vivo.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        opensource.kernel@vivo.com, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>
Subject: Re: Re: [PATCH] gpu/drm/mgag200:remove break after return
Message-ID: <20201024171457.GA76883@ravnborg.org>
References: <a6eab3c7-f1dd-82db-1cc0-35997c04bd7d@suse.de>
 <ADgA6wAcDbnOQfg3AhKb6KoN.3.1603439329788.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ADgA6wAcDbnOQfg3AhKb6KoN.3.1603439329788.Hmail.bernard@vivo.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=S433PrkP c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=1WtWmnkvAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=24COTcmDj64ZDdr2WTQA:9 a=CjuIK1q_8ugA:10 a=-_UHfarfsM-RsASml2Jt:22
        a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard.

On Fri, Oct 23, 2020 at 03:48:49PM +0800, Bernard wrote:
> 
> 
> From: Thomas Zimmermann <tzimmermann@suse.de>
> Date: 2020-10-23 15:13:30
> To:  Bernard Zhao <bernard@vivo.com>,Dave Airlie <airlied@redhat.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org
> Cc:  opensource.kernel@vivo.com
> Subject: Re: [PATCH] gpu/drm/mgag200:remove break after return>Hi
> >
> >On 23.10.20 09:00, Bernard Zhao wrote:
> >> In function mgag200_set_pci_regs, there are some switch cases
> >> returned, then break. These break will never run.
> >> This patch is to make the code a bit readable.
> >> 
> >> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> >> ---
> >>  drivers/gpu/drm/mgag200/mgag200_mode.c | 5 +----
> >>  1 file changed, 1 insertion(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> >> index 38672f9e5c4f..de873a5d276e 100644
> >> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> >> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> >> @@ -794,20 +794,17 @@ static int mgag200_crtc_set_plls(struct mga_device *mdev, long clock)
> >>  	case G200_SE_A:
> >>  	case G200_SE_B:
> >>  		return mga_g200se_set_plls(mdev, clock);
> >> -		break;
> >>  	case G200_WB:
> >>  	case G200_EW3:
> >>  		return mga_g200wb_set_plls(mdev, clock);
> >> -		break;
> >>  	case G200_EV:
> >>  		return mga_g200ev_set_plls(mdev, clock);
> >> -		break;
> >>  	case G200_EH:
> >>  	case G200_EH3:
> >>  		return mga_g200eh_set_plls(mdev, clock);
> >> -		break;
> >>  	case G200_ER:
> >>  		return mga_g200er_set_plls(mdev, clock);
> >> +	default:
> >
> >No default case here. If one of the enum values is not handled by the
> >switch, the compiler should warn about it.
> 
> Hi
> 
> For this point I was a little confused, about this switch variable "mdev->type", my understanding is that this variable`s value can be certain only when the code is running.
> How does the compiler warn this("If one of the enum values is not handled") before the code runs?

If the switch/case does not include "G200_ER" then the compiler can see
one enum value is missing from the list and can warn.
As a test - Try to drop the default and drop G200_ER - then the
compiler (hopefully) will warn.

	Sam
