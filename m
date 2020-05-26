Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3783D1A8F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 02:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634531AbgDOAAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 20:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbgDOAAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:00:08 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708142076B;
        Wed, 15 Apr 2020 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586908806;
        bh=tprMW0nZ8qX7OXgH2aBCLUqe3UgrhXvXYcvonQYqR8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dRds5zbkwZvSY35f8BZ4t/gYFBjy/YnN7aknpaHu4qsiXgda/qsruLojctfVJaxRT
         UwJ7C6napNWIYvNfmB3/3d1/CzwUs2LxRpCMtduNRRXK8+3Pi+Rkp1sqB+aTPHSoxc
         46SzFugktcKbI8OQWYPs3OmaTN9Gq/uReyUP+XCQ=
Date:   Tue, 14 Apr 2020 17:00:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     George Burgess IV <gbiv@google.com>
Cc:     ndesaulniers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/build: tweak unused value workaround
Message-Id: <20200414170006.10f70d361bfd085f3e846939@linux-foundation.org>
In-Reply-To: <20200414195638.156123-1-gbiv@google.com>
References: <20200414195638.156123-1-gbiv@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 12:56:38 -0700 George Burgess IV <gbiv@google.com> wrote:

> Clang has -Wself-assign enabled by default under -Wall, which always
> gets -Werror'ed on this file, causing sync-compare-and-swap to be
> disabled by default. The generally-accepted way to spell "this value is
> intentionally unused," is casting it to `void`. This is accepted by both
> GCC and Clang with -Wall enabled: https://godbolt.org/z/qqZ9r3
> 

What does "disabled by default" mean?  Presumably it should now be
enabled, but I don't think this disabling happens in the mainline
kernel tree?

