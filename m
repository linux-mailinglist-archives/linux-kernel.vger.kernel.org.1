Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4FB274F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 05:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIWDi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 23:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgIWDi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 23:38:56 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E7DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 20:38:56 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKvcG-004Gil-QP; Wed, 23 Sep 2020 03:38:48 +0000
Date:   Wed, 23 Sep 2020 04:38:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200923033848.GD3421308@ZenIV.linux.org.uk>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914195354.yghlqlwtqz7mqteb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914195354.yghlqlwtqz7mqteb@treble>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 02:53:54PM -0500, Josh Poimboeuf wrote:
> Al,
> 
> This depends on Christoph's set_fs() removal patches.  Would you be
> willing to take this in your tree?

in #uaccess.x86 and #for-next
