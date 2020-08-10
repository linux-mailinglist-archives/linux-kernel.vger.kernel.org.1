Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B7F2405CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHJMYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:24:23 -0400
Received: from verein.lst.de ([213.95.11.211]:60882 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgHJMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:24:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D43FF68AFE; Mon, 10 Aug 2020 14:24:19 +0200 (CEST)
Date:   Mon, 10 Aug 2020 14:24:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200810122419.GA19656@lst.de>
References: <20200808223802.11451-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808223802.11451-1-peterx@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only seems to add a flag, but no actual user of it.
