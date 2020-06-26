Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C824320AB70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 06:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgFZEqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 00:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgFZEqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:46:06 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279EFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:46:06 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPTj1HL0z9sTM; Fri, 26 Jun 2020 14:46:00 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
In-Reply-To: <202006050717.A2F9809E@keescook>
References: <202006050717.A2F9809E@keescook>
Subject: Re: [PATCH] powerpc/mm: Fix typo in IS_ENABLED()
Message-Id: <159314672435.1150869.14310189656762356472.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:46:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 07:18:06 -0700, Kees Cook wrote:
> IS_ENABLED() matches names exactly, so the missing "CONFIG_" prefix
> means this code would never be built.
> 
> Also fixes a missing newline in pr_warn().

Applied to powerpc/next.

[1/1] powerpc/mm: Fix typo in IS_ENABLED()
      https://git.kernel.org/powerpc/c/55bd9ac468397c4f12a33b7ec714b5d0362c3aa2

cheers
