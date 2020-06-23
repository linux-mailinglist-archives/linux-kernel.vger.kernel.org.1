Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E83206702
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 00:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbgFWWLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 18:11:44 -0400
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:45068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387840AbgFWWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:11:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 93F1F100E7B40;
        Tue, 23 Jun 2020 22:11:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:4321:5007:7576:10004:10400:10848:11026:11232:11657:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21972:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: alley94_42139ce26e3f
X-Filterd-Recvd-Size: 1825
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 22:11:40 +0000 (UTC)
Message-ID: <25a963df43bfa4a1099b6813bb35d9c5a6184578.camel@perches.com>
Subject: Re: [PATCH 03/50] staging: mmal-vchiq: Avoid use of bool in
 structures
From:   Joe Perches <joe@perches.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Date:   Tue, 23 Jun 2020 15:11:39 -0700
In-Reply-To: <20200623164235.29566-4-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
         <20200623164235.29566-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 18:41 +0200, Nicolas Saenz Julienne wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> 
> Fixes up a checkpatch error "Avoid using bool structure members
> because of possible alignment issues".
[]
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
[]
> @@ -1754,7 +1754,7 @@ int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
>  
>  	ret = enable_component(instance, component);
>  	if (ret == 0)
> -		component->enabled = true;
> +		component->enabled = 1;

This change does not match the commit description.

Also, checkpatch does not emit a warning here.


