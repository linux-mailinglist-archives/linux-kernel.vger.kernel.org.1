Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70E328EE69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbgJOIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:23:34 -0400
Received: from gentwo.org ([3.19.106.255]:51678 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgJOIXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:23:34 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 1529E3F0EE; Thu, 15 Oct 2020 08:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 12ACA3F042;
        Thu, 15 Oct 2020 08:23:33 +0000 (UTC)
Date:   Thu, 15 Oct 2020 08:23:33 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Kees Cook <keescook@chromium.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Marco Elver <elver@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] Actually fix freelist pointer vs redzoning
In-Reply-To: <20201015033712.1491731-1-keescook@chromium.org>
Message-ID: <alpine.DEB.2.22.394.2010150822260.184556@www.lameter.com>
References: <20201015033712.1491731-1-keescook@chromium.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020, Kees Cook wrote:

> Note on patch 2: Christopher NAKed it, but I actually think this is a
> reasonable thing to add -- the "too small" check is only made when built
> with CONFIG_DEBUG_VM, so it *is* actually possible for someone to trip
> over this directly, even if it would never make it into a released
> kernel. I see no reason to just leave this foot-gun in place, though, so
> we might as well just fix it too. (Which seems to be what Longman was
> similarly supporting, IIUC.)

Well then remove the duplication of checks. The NAK was there because it
seems that you were not aware of the existing checks.

> Anyway, if patch 2 stays NAKed, that's fine. It's entirely separable,
> and the other 2 can land. :)

Just deal with the old checks too and it will be fine.

