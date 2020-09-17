Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65E26DA28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIQL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgIQL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:30 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC5C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:22 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSR6pGWz9sV0; Thu, 17 Sep 2020 21:27:19 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <346f65d677adb11865f7762c25a1ca3c64404ba5.1599216023.git.christophe.leroy@csgroup.eu>
References: <346f65d677adb11865f7762c25a1ca3c64404ba5.1599216023.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/uaccess: Add pre-update addressing to __put_user_asm_goto()
Message-Id: <160034201358.3339803.7851441214303980788.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:19 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 10:46:47 +0000 (UTC), Christophe Leroy wrote:
> Enable pre-update addressing mode in __put_user_asm_goto()

Applied to powerpc/next.

[1/1] powerpc/uaccess: Add pre-update addressing to __put_user_asm_goto()
      https://git.kernel.org/powerpc/c/fcf1f26895a4f14618b0dc04e0801b123c55e4a3

cheers
