Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF931D57F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 19:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgEORcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEORb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:31:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2004C061A0C;
        Fri, 15 May 2020 10:31:59 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A0DAE72D;
        Fri, 15 May 2020 17:31:59 +0000 (UTC)
Date:   Fri, 15 May 2020 11:31:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: debugfs: Update struct debugfs_reg32 definition
Message-ID: <20200515113158.35b8f73b@lwn.net>
In-Reply-To: <20200508212949.2867-1-rikard.falkeborn@gmail.com>
References: <20200508212949.2867-1-rikard.falkeborn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 May 2020 23:29:49 +0200
Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> Update the docs to match the implementation, both the definition of
> struct debugfs_regset32 and the definition of debugfs_print_regs32().
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Applied, thanks.

jon
