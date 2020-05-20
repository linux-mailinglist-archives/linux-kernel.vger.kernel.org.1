Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34891DB0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 13:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgETLAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 07:00:04 -0400
Received: from ozlabs.org ([203.11.71.1]:39703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgETK77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:59:59 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49RqXG0M5Dz9sV0; Wed, 20 May 2020 20:59:57 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200507185749.GA14994@embeddedor>
References: <20200507185749.GA14994@embeddedor>
Subject: Re: [PATCH] powerpc: Replace zero-length array with flexible-array
Message-Id: <158997213812.943180.11477022501548929262.b4-ty@ellerman.id.au>
Date:   Wed, 20 May 2020 20:59:57 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 13:57:49 -0500, Gustavo A. R. Silva wrote:
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

[1/1] powerpc: Replace zero-length array with flexible-array
      https://git.kernel.org/powerpc/c/0f6be41c60699fd8cdfa93e5e85a306cec1ac1d0

cheers
