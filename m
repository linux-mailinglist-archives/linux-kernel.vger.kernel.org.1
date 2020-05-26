Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FFE1B8DA4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDZHvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 03:51:50 -0400
Received: from relay.sw.ru ([185.231.240.75]:60556 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgDZHvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 03:51:49 -0400
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1jSc4V-0002AX-S7; Sun, 26 Apr 2020 10:51:28 +0300
Subject: Re: [PATCH 1/1] drm/qxl: add mutex_lock/mutex_unlock to ensure the
 order in which resources are released
To:     Caicai <caizhaopeng@uniontech.com>,
        Dave Airlie <airlied@redhat.com>
References: <20200418063917.26278-1-caizhaopeng () uniontech ! com>
From:   Vasily Averin <vvs@virtuozzo.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangyueqian <zhangyueqian@uniontech.com>
Message-ID: <5488290f-fe60-874e-2b18-0327e877fdbc@virtuozzo.com>
Date:   Sun, 26 Apr 2020 10:51:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418063917.26278-1-caizhaopeng () uniontech ! com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/20 9:39 AM, Caicai wrote:
> When a qxl resource is released, the list that needs to be released is
> fetched from the linked list ring and cleared. When you empty the list,
> instead of trying to determine whether the ttm buffer object for each
> qxl in the list is locked, you release the qxl object and remove the
> element from the list until the list is empty. It was found that the
> linked list was cleared first, and that the lock on the corresponding
> ttm Bo for the QXL had not been released, so that the new qxl could not
> be locked when it used the TTM. By adding an additional mutex to ensure
> timing, qxl elements are not allowed to be removed from the list until
> ttm Bo's lock is released

> @@ -241,7 +243,11 @@ int qxl_garbage_collect(struct qxl_device *qdev)
>  			}
>  			id = next_id;
>  
> +			mutex_lock(&release->async_release_mutex);
> +
>  			qxl_release_free(qdev, release);
> +
> +			mutex_unlock(&release->async_release_mutex);
It does not work,
release was freed inside qxl_release_free() so you cannot access here any its fields

>  			++i;
>  		}
>  	}
