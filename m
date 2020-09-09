Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3DA2631DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbgIIQ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbgIIQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:40 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0C2C061786
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:40 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVq4KxKz9sTv; Wed,  9 Sep 2020 23:27:30 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d5641ada199b8dd2af16ad00a66084cf974f2704.1596716418.git.christophe.leroy@csgroup.eu>
References: <d5641ada199b8dd2af16ad00a66084cf974f2704.1596716418.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/fpu: Drop cvt_fd() and cvt_df()
Message-Id: <159965716721.808686.10133921588629579775.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:30 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 12:20:34 +0000 (UTC), Christophe Leroy wrote:
> Those two functions have been unused since commit identified below.
> Drop them.

Applied to powerpc/next.

[1/2] powerpc/fpu: Drop cvt_fd() and cvt_df()
      https://git.kernel.org/powerpc/c/63442de4301188129e1fcff144fbfb966ad5eb19
[2/2] powerpc: drop hard_reset_now() and poweroff_now() declaration
      https://git.kernel.org/powerpc/c/82eb1792426f8a171cdaa6cfccb63c39f55bc9bd

cheers
