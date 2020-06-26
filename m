Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA82E20AB71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 06:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgFZEqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 00:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgFZEqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:46:03 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFFFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:46:02 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPTg0x1Nz9sTF; Fri, 26 Jun 2020 14:45:58 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        John Crispin <john@phrozen.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Imre Kaloz <kaloz@openwrt.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1482393968-60623-1-git-send-email-john@phrozen.org>
References: <1482393968-60623-1-git-send-email-john@phrozen.org>
Subject: Re: [PATCH] arch: powerpc: ppc4xx compile flag optimizations
Message-Id: <159314672783.1150869.15085498536728162262.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:45:58 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2016 09:06:08 +0100, John Crispin wrote:
> This patch splits up the compile flags between ppc40x and ppc44x.

Applied to powerpc/next.

[1/1] powerpc/4xx: ppc4xx compile flag optimizations
      https://git.kernel.org/powerpc/c/548ad77d10f7ad6e5f84a0026978da2ed1df0dae

cheers
