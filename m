Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733FD2632F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgIIQyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgIIP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:57:19 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC273C0617BA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:38:39 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjkS68hFz9sVT; Wed,  9 Sep 2020 23:37:36 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <michael@ellerman.id.au>,
        Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1530522496-14816-1-git-send-email-hofrat@osadl.org>
References: <1530522496-14816-1-git-send-email-hofrat@osadl.org>
Subject: Re: [PATCH] powerpc: hwrng; fix missing of_node_put()
Message-Id: <159965824096.811679.9956430323113603887.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:37:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 11:08:16 +0200, Nicholas Mc Guire wrote:
>  The call to of_find_compatible_node() returns a node pointer with refcount
> incremented thus it must be explicitly decremented here before returning.

Applied to powerpc/next.

[1/1] powerpc/pseries: Fix missing of_node_put() in rng_init()
      https://git.kernel.org/powerpc/c/67c3e59443f5fc77be39e2ce0db75fbfa78c7965

cheers
