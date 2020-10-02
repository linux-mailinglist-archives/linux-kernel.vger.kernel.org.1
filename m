Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC050280DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgJBHGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:06:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBHGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:06:24 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 03:06:24 EDT
Received: from localhost ([178.19.226.45]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCJzI-1kEveq3PzG-009N3V; Fri, 02 Oct 2020 09:01:14 +0200
Date:   Fri, 2 Oct 2020 09:01:14 +0200
From:   Bastian Bittorf <bb@npl.de>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 5.9-rc7 / VmallocTotal wrongly reported | Patch OK
Message-ID: <20201002070114.do3xmia7sbsnrx6h@hp-nas.internet>
References: <20201001065104.apevlkqrs6nid3r5@hp-nas.internet>
 <CAHk-=wixd9kUup4o1d1y9Wg9WoRt6_mN7kM5sPX=_nrgrkZzFg@mail.gmail.com>
 <20201001195610.GC2706729@carbon.DHCP.thefacebook.com>
 <CAHk-=whwbrbZbdqpXVd9LOG=J04BEVZcT+vT=nXry=XP1JWqYA@mail.gmail.com>
 <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
User-Agent: NeoMutt/20180716-942-b29a2a
X-Provags-ID: V03:K1:NGgDvJ4n7LguwDte1GnQ2AKEdedg2BBPuwrBuPsWUxelDMLXw34
 fic3muZIbZ9D00kOBrlIH4KDupo90da9YW1GPnrFH4ZTJKSebZtCew7Sxac2Jx8DBvg7IK9
 eQpKKgnLy6h+Mt3UFn1wJdyQiVzEGWqmm8JA9EFhfy1Qs6d/cYRVqmkuiMZ9L0m7PEGqx5K
 vp9MJVrCdfk0Q+Ye0y9aQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IF1vpbaN9ZI=:q4hw5kQU6GUqllvsPEjLM9
 DYbVvCzYbfTIihb7AejIde3YSW30FnG0y0YcCYFnkNYGa+gUxHijYatmFQ6Af6/hijgyTX8JT
 XIRHtBcSAGLEmEcB8Kn6Tmw3ZZ9ORC1bYJSOFK0uolxdedd21y1vdBfg3ih0UO7CiPL7R+FAJ
 0rwMYByhrdW5CKhku4cs0NMx0cqRnf+Up5BzsY6e728AvvVh6YPW4NqruRN+JP7/UTfq1y78S
 HBAptjd/Gp2hCb75ND6t27wr/+GZqSNFjA+tRyBty/F6l26MGP+0XnY62T5GYy1AziPHDTStt
 bvXv9BnUxqKvIbwzEtC+hPk4fmPB/7cK/9uHiIfLbK+xbLIGoHinX07dPe/fJrYwSdxU8HMZS
 pf9nvWPqJNU8juOvXrnrmY+bXRyQIz71C9mv5TchLZsSViiAlFNVBHLJOGbo5GXBvCyAZs3hP
 MjJblPkSziZCo6ecKuy1L477AQhcNhCVVn9Y3U+b2kZOV0htjukrtsnWVkyUPJPc2AC9itpEe
 BitiRoRnGKBWQbv2lnJyXZ4eu/OdFO9TgI3Dbx5tRQMQ7soH7Q+uGEh6Oo8TrA4BVZMu/GqwQ
 iWjD7wYFTOQK94m04n0pcrruL6EL8/W8UlzBcNIava6PTeDQY287Pvuvr5hu7KlW39LinoMRS
 vpVTjlMrmFALnBscXMfV5hfxKuC9B85o8rp5vaBP+KABdaWm5IcRovpKP8lkJRLtfe+RqmJ0Y
 vnpoQQPNqlXZpq83fO/0zqz2h3LUFX7wgZaGHI+Rb2EFcGCMJmDz6Jf9IfDispgPhGfFCMqI8
 fTWGNRnX/xU/jCI6XBIa0X3wlk9EmGDMYHC/WX2N3idboObtlyLn3x97HYeU21czwt3wneq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 01:39:31PM -0700, Roman Gushchin wrote:
> > # Processor type and features
> > #
> > # CONFIG_ZONE_DMA is not set
> > # CONFIG_SMP is not set
> 
> Yes, here is the deal.
> 
> The SMP-version of __mod_node_page_state() converts a passed value from bytes
> to pages, but the non-SMP doesn't.
> 
> Thanks!
> 
> --
> 
> From 3d0233b37340c78012b991d3570b92f91cf5ebd2 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Thu, 1 Oct 2020 13:07:49 -0700
> Subject: [PATCH] mm: memcg/slab: fix slab statistics in !SMP configuration


I manually applied your patch and
this fixes to issue on my side too:

/ # free
              total        used        free      shared  buff/cache available
Mem:         122176        2484      114848           0        4844
113228
Swap:             0           0           0

/ # uname -a
Linux (none) 5.9.0-rc7 #1 Fri Oct 2 08:50:59 CEST 2020 x86_64 GNU/Linux
/ #

Thanks a lot and sorry for the delay (my bisecting was too slow),
bye Bastian Bittorf

