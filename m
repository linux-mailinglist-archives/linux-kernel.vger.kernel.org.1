Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC51DB0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 13:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgETLAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 07:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgETK77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:59:59 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4B9C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:59:58 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49RqXD748lz9sTn; Wed, 20 May 2020 20:59:56 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20200507185755.GA15014@embeddedor>
References: <20200507185755.GA15014@embeddedor>
Subject: Re: [PATCH] powerpc/mm: Replace zero-length array with flexible-array
Message-Id: <158997213838.943180.15630972837111917631.b4-ty@ellerman.id.au>
Date:   Wed, 20 May 2020 20:59:56 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 13:57:55 -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm: Replace zero-length array with flexible-array
      https://git.kernel.org/powerpc/c/02bddf21c34d0a918acc8647195ba4507e3db8fc

cheers
