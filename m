Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FFA26DA52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIQLel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgIQL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:49 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A35C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:46 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSZ0jw0z9sVX; Thu, 17 Sep 2020 21:27:25 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <21b05f7298c1b18f73e6e5b4cd5005aafa24b6da.1599820109.git.christophe.leroy@csgroup.eu>
References: <21b05f7298c1b18f73e6e5b4cd5005aafa24b6da.1599820109.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/powermac: Fix low_sleep_handler with KUAP and KUEP
Message-Id: <160034201640.3339803.9937170940797362812.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:25 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 10:29:15 +0000 (UTC), Christophe Leroy wrote:
> low_sleep_handler() has an hardcoded restore of segment registers
> that doesn't take KUAP and KUEP into account.
> 
> Use head_32's load_segment_registers() routine instead.

Applied to powerpc/next.

[1/1] powerpc/powermac: Fix low_sleep_handler with KUAP and KUEP
      https://git.kernel.org/powerpc/c/2c637d2df4ee4830e9d3eb2bd5412250522ce96e

cheers
