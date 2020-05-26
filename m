Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0801BA9D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgD0QKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:10:32 -0400
Received: from gentwo.org ([3.19.106.255]:35258 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgD0QKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:10:32 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 82DFF3F4ED; Mon, 27 Apr 2020 16:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 81ACC3E8A0;
        Mon, 27 Apr 2020 16:10:31 +0000 (UTC)
Date:   Mon, 27 Apr 2020 16:10:31 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Waiman Long <longman@redhat.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm/slub: Fix incorrect interpretation of s->offset
In-Reply-To: <20200427140822.18619-1-longman@redhat.com>
Message-ID: <alpine.DEB.2.21.2004271606390.26716@www.lameter.com>
References: <20200427140822.18619-1-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Waiman Long wrote:

>
> To fix it, use the check "s->offset == s->inuse" in the new helper
> function freeptr_after_object() instead. Also add another helper function
> get_info_end() to return the end of info block (inuse + free pointer
> if not overlapping with object).
>
> Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/slub.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 0e736d66bb42..68f1b4b1c309 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -551,15 +551,29 @@ static void print_section(char *level, char *text, u8 *addr,
>  	metadata_access_disable();
>  }
>
> +static inline bool freeptr_after_object(struct kmem_cache *s)

bool freeptr_outside_of_object()?

> +{
> +	return s->offset == s->inuse;

s->offset >= s->inuse?

There may be a redzone after the object.


> +static inline unsigned int get_info_end(struct kmem_cache *s)

static inline track_offset()?

