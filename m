Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF123B4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 08:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgHDGLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 02:11:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:33104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbgHDGLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:11:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD44FAC7D;
        Tue,  4 Aug 2020 06:12:03 +0000 (UTC)
Subject: Re: [PATCH 1/6] xen/gntdev: Fix dmabuf import with non-zero sgt
 offset
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20200731125109.18666-1-andr2000@gmail.com>
 <20200731125109.18666-2-andr2000@gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <acf507b8-462a-1fa0-c54f-cc5c44d3cc55@suse.com>
Date:   Tue, 4 Aug 2020 08:11:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731125109.18666-2-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.20 14:51, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> It is possible that the scatter-gather table during dmabuf import has
> non-zero offset of the data, but user-space doesn't expect that.
> Fix this by failing the import, so user-space doesn't access wrong data.
> 
> Fixes: 37ccb44d0b00 ("xen/gntdev: Implement dma-buf import functionality")

I can't find this commit in the tree. Did you mean bf8dc55b1358?

And don't you want to Cc stable for this patch, too?

> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen
