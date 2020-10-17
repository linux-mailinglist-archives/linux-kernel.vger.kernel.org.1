Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFDC2910A5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 10:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411389AbgJQIDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 04:03:19 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47310 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408165AbgJQIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 04:03:16 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E06FD80613;
        Sat, 17 Oct 2020 10:03:13 +0200 (CEST)
Date:   Sat, 17 Oct 2020 10:03:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinay Simha B N <simhavcs@gmail.com>
Cc:     Vinay Simha B N <simhavcs@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH] drm/bridge/tc358775: Fixes bus formats read
Message-ID: <20201017080312.GB2568873@ravnborg.org>
References: <1597217150-22911-1-git-send-email-simhavcs@gmail.com>
 <20200812095418.GG6057@pendragon.ideasonboard.com>
 <CAGWqDJ4i=t4Noi7wjGDDhUYkB_uuQ6A-WiMrh1ErKRi2HU9t9w@mail.gmail.com>
 <20200812131818.GI6057@pendragon.ideasonboard.com>
 <CAGWqDJ6eHCNXb5dMCUJ785iUp7gjdCk0bB=GuZesVesaVACucQ@mail.gmail.com>
 <CAGWqDJ5QWyvgJWyink1eH2fHhFWEKSei7XPCdtCRaM1BqRs-Tw@mail.gmail.com>
 <CAGWqDJ7DQbnxBmL9xt3cJoXkcm4aU1Msf-MiJOi12hd61GbJpg@mail.gmail.com>
 <CAGWqDJ4eqDNZFz+F2ybaCzuZ=bvr_4hFq=GGMmPCK0zY1KcyPw@mail.gmail.com>
 <CAGWqDJ4zHO4sjXOkG=iSeBhJn4J9+ccr6CKOKcAEBxU31b4VGw@mail.gmail.com>
 <20200908175707.GH11405@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908175707.GH11405@pendragon.ideasonboard.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=GvDVO_YM4ib0h8v04t0A:9 a=CjuIK1q_8ugA:10
        a=QYH75iMubAgA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinay

On Tue, Sep 08, 2020 at 08:57:07PM +0300, Laurent Pinchart wrote:
> Hi Vinay,
> 
> On Tue, Sep 08, 2020 at 11:22:48PM +0530, Vinay Simha B N wrote:
> > laurent,
> > 
> > Please review or give some feedback.
> 
> I'm sorry, I have very little time these days :-( Maybe Neil can provide
> feedback ?

I have lost the original patch - if this is still pending could you then
please resend.

Thanks,

	Sam
