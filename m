Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EF12631F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgIIQbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbgIIQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:29 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D416CC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:28:37 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVt75QJz9sV5; Wed,  9 Sep 2020 23:27:34 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <9d11143d4e27ba8274369a926968756917584868.1597643153.git.christophe.leroy@csgroup.eu>
References: <9d11143d4e27ba8274369a926968756917584868.1597643153.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc/process: Remove unnecessary #ifdef CONFIG_FUNCTION_GRAPH_TRACER
Message-Id: <159965717089.808686.6746767458017172560.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 05:46:39 +0000 (UTC), Christophe Leroy wrote:
> ftrace_graph_ret_addr() is always defined and returns 'ip' when
> CONFIG_FUNCTION GRAPH_TRACER is not set.
> 
> So the #ifdef is not needed, remove it.

Applied to powerpc/next.

[1/1] powerpc/process: Remove unnecessary #ifdef CONFIG_FUNCTION_GRAPH_TRACER
      https://git.kernel.org/powerpc/c/353bce211e00d183344f464ba1ee0e1ffb0e2a6c

cheers
