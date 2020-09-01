Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08462592B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgIAPQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 11:16:00 -0400
Received: from verein.lst.de ([213.95.11.211]:53783 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729168AbgIAPPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:15:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E164B68B05; Tue,  1 Sep 2020 17:15:00 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:15:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/6] sysctl: make proc_put_long() use scnprintf
Message-ID: <20200901151500.GD30709@lst.de>
References: <20200813210411.905010-1-josef@toxicpanda.com> <20200813210411.905010-5-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813210411.905010-5-josef@toxicpanda.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:04:09PM -0400, Josef Bacik wrote:
> Now that we're passing down a kernel buffer with enough space to account
> for an extra NULL terminator, go ahead and use scnprintf() to print out
> a long in proc_put_long().  count here includes NULL terminator slot in
> the buffer, so we will get the correct behavior we're looking for.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
