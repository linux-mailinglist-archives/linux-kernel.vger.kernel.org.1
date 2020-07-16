Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C62222303
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGPM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPM4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:01 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B978C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:56:01 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPh0ndYz9sV1; Thu, 16 Jul 2020 22:55:52 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <810bd8840ef990a200f58c9dea9abe767ca02a3a.1594146723.git.christophe.leroy@csgroup.eu>
References: <810bd8840ef990a200f58c9dea9abe767ca02a3a.1594146723.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/signal64: Don't opencode page prefaulting
Message-Id: <159490400694.3805857.15212813327289950599.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:52 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 18:32:25 +0000 (UTC), Christophe Leroy wrote:
> Instead of doing a __get_user() from the first and last location
> into a tmp var which won't be used, use fault_in_pages_readable()

Applied to powerpc/next.

[1/1] powerpc/signal64: Don't opencode page prefaulting
      https://git.kernel.org/powerpc/c/96032f983ca32ad1d43c73da922dbc7022754c3c

cheers
