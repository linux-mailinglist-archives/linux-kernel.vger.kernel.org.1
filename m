Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45509263206
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgIIQeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbgIIQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:32:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18E1C0617A4;
        Wed,  9 Sep 2020 06:29:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjW14T0yz9sVm; Wed,  9 Sep 2020 23:27:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Wolfram Sang <wsa@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200806102901.44988-1-colin.king@canonical.com>
References: <20200806102901.44988-1-colin.king@canonical.com>
Subject: Re: [PATCH][V2] macintosh: windfarm: remove detatch debug containing spelling mistakes
Message-Id: <159965716592.808686.16632951735856644964.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:41 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 11:29:01 +0100, Colin King wrote:
> There are spelling mistakes in two debug messages. As recommended
> by Wolfram Sang, these can be removed as there is plenty of debug
> in the driver core.

Applied to powerpc/next.

[1/1] macintosh: windfarm: remove detatch debug containing spelling mistakes
      https://git.kernel.org/powerpc/c/7db0a07273e8f581d0b3e8a102d3d9dd99f43528

cheers
