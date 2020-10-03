Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558F828210C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 06:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJCEI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 00:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgJCEI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 00:08:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11D1C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 21:08:58 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOYqv-00Apfv-Aw; Sat, 03 Oct 2020 04:08:57 +0000
Date:   Sat, 3 Oct 2020 05:08:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compat: move strut compat_iovec out of #ifdef
 CONFIG_COMPAT
Message-ID: <20201003040857.GL3421308@ZenIV.linux.org.uk>
References: <20200928161414.642727-1-hch@lst.de>
 <20201002061512.GA9230@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002061512.GA9230@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 08:15:12AM +0200, Christoph Hellwig wrote:
> ping?  This is needed to unbreak the work.iov_iter branch that is in
> for-next.

Folded into "iov_iter: refactor rw_copy_check_uvector and import_iovec"
and force-pushed...
