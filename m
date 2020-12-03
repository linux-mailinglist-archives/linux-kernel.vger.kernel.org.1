Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297C02CD9D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgLCPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:06:34 -0500
Received: from ms.lwn.net ([45.79.88.28]:54664 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730782AbgLCPGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:06:34 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D84521C1D;
        Thu,  3 Dec 2020 15:05:53 +0000 (UTC)
Date:   Thu, 3 Dec 2020 08:05:52 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix typos found in admin-guide
 subdirectory
Message-ID: <20201203080552.5411702f@lwn.net>
In-Reply-To: <CA+mfrmy-cWfT+GJK1WiqVm8_CrUmCFP_0xDkoCGhyc0qi=i+Jw@mail.gmail.com>
References: <20201202084400.GA38345@spblnx124.lan>
        <1f1cc1c8-9e8e-893c-b1e4-509f042caca2@infradead.org>
        <CA+mfrmy-cWfT+GJK1WiqVm8_CrUmCFP_0xDkoCGhyc0qi=i+Jw@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 06:52:30 +0300
Andrew Klychkov <andrew.a.klychkov@gmail.com> wrote:

> Should i fix the patch or you’ll just exclude this part yourself?

Please send a fixed version with Randy's Reviewed-by tag added as well.

The right way to fix that might be "ANDed" to make it what is being said
clear.

Thanks,

jon
