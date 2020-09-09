Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD472631D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgIIQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbgIIQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:40 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184ECC0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:28:49 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjW04ZHsz9sVk; Wed,  9 Sep 2020 23:27:40 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <c27bc4e598daf3bbb225de7a1f5c52121cf1e279.1597235091.git.christophe.leroy@csgroup.eu>
References: <c27bc4e598daf3bbb225de7a1f5c52121cf1e279.1597235091.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/2] powerpc/uaccess: Use flexible addressing with __put_user()/__get_user()
Message-Id: <159965717070.808686.8733357237820602435.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 12:25:16 +0000 (UTC), Christophe Leroy wrote:
> At the time being, __put_user()/__get_user() and friends only use
> D-form addressing, with 0 offset. Ex:
> 
> 	lwz	reg1, 0(reg2)
> 
> Give the compiler the opportunity to use other adressing modes
> whenever possible, to get more optimised code.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/uaccess: Use flexible addressing with __put_user()/__get_user()
      https://git.kernel.org/powerpc/c/c20beffeec3cb6f6f52d9aef27f91a3f453a91f4
[2/2] powerpc/uaccess: Add pre-update addressing to __get_user_asm() and __put_user_asm()
      https://git.kernel.org/powerpc/c/2f279eeb68b8eda43a95255db701b4faaeedbe0f

cheers
