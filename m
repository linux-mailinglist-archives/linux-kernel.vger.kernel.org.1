Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1952822E19E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGZRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgGZRVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:21:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C626C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 10:21:38 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzkKj-0037Ru-Pn; Sun, 26 Jul 2020 17:21:09 +0000
Date:   Sun, 26 Jul 2020 18:21:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     zhouchuangao <chuangaozhou@gmail.com>
Cc:     linux@dominikbrodowski.net, pc@cjr.nz, axboe@kernel.dk,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@xiaomi.com>
Subject: Re: [PATCH] init/do_mounts: fix a coding style error
Message-ID: <20200726172109.GV2786714@ZenIV.linux.org.uk>
References: <1594710178-27825-1-git-send-email-zhouchuangao@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594710178-27825-1-git-send-email-zhouchuangao@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 03:02:58PM +0800, zhouchuangao wrote:
> Fix code style errors reported by scripts/checkpatch.pl.

NAKed-because: excessive deference to checkpatch.pl

It's not a holy oracle than needs to be appeased, no questions
asked.  Reference to it is absolutely insufficient reason for
_anything_ - in effect your commit message could've been
"just because" for all the information it contains.
