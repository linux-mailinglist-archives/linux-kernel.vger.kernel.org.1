Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF52A65A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgKDOAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:00:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:37106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbgKDOAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:00:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6C51ADE8;
        Wed,  4 Nov 2020 14:00:19 +0000 (UTC)
Date:   Wed, 4 Nov 2020 15:00:19 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 0/3] module: refactor module_sig_check()
In-Reply-To: <22e48a3d-06ee-5b8e-6e56-3694871a7c2f@omprussia.ru>
Message-ID: <alpine.LSU.2.21.2011041500020.14700@pobox.suse.cz>
References: <22e48a3d-06ee-5b8e-6e56-3694871a7c2f@omprussia.ru>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020, Sergey Shtylyov wrote:

> Here are 3 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
> I'm doing some refactoring in module_sig_check()...
> 
> [1/3] module: merge repetitive strings in module_sig_check()
> [2/3] module: avoid *goto*s in module_sig_check()
> [3/3] module: only handle errors with the *switch* statement in module_sig_check()

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
