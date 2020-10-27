Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE82B29A79B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505496AbgJ0JSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404675AbgJ0JSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603790290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PP9XfWWYs/ZL8eWntPMtO6Zbh5hoxUuR0KDIP5S05yQ=;
        b=iL1e1B1YBFAgIn+M8SLjs5oBL1jF1xLpp+UMRwAjMWBu83weKYyJF6BGMixi0Bbb6WgcZ1
        3eLbTHHw1HerMN1qlPNy67NZC3c/xEuCOvTvKh4Hn+6DIcMZoGcBfYnSi9o+qFRaEHnxrP
        h984oQxqy0mU+8fZxq76UXbKMSN0lKY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-jP-GUqW7Mqi8cqOxFCzmvw-1; Tue, 27 Oct 2020 05:18:09 -0400
X-MC-Unique: jP-GUqW7Mqi8cqOxFCzmvw-1
Received: by mail-wr1-f72.google.com with SMTP id n14so514974wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 02:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PP9XfWWYs/ZL8eWntPMtO6Zbh5hoxUuR0KDIP5S05yQ=;
        b=OhZruHBb0HZwPVSDtzyCaNYopbx46uvqDChoiYIT6u3voU8iYwGE4zImcRf0/Tye5B
         oaF6Wm2fZfq2UFXw6TxmGm4MZzCqSgTeTONpVwiXMnzOIU4qdbQv2vpDqq/JpGkpIReW
         mk3zXez4UhLZolE7I/6zHb2QIn4UT1cTiiGd8MO549uJTW33FZz8TH6I9J0fCk1vfKFX
         khS3bWhfeAfG3m/N9hhaYP0Mwlow7VRT+gre6KCw2tLWKnlio+iCPz4HJj6twuDZAgC+
         EsZjNecjjcThZmz9cau+HntdMFFOXSNYKwZAlS3c7p34RYRzLmGnvQrVumXMJMVCBgzK
         QcpQ==
X-Gm-Message-State: AOAM533EMvt2mhI4GRLr++w0qbq0R0RMu2tBLhua3xBLe3OquYaPPRef
        HKuUqurQ3C/RCQ0TSPP3+JKru/QSO3nL5/knGq6HJfdZw6KdDoQQqGGhhui4VcYY/wRe2uY7bNh
        THxw44jJ8xocxOE4xRwOz+JIu
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr1612044wmo.143.1603790287167;
        Tue, 27 Oct 2020 02:18:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIilyoqRxGaUl7p9JKTfBssuH7mohx3h+nf+wqghU8Ac68i7Wh1Yp/SFLOvnj3tU5GpJwc5Q==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr1612024wmo.143.1603790286960;
        Tue, 27 Oct 2020 02:18:06 -0700 (PDT)
Received: from steredhat (host-79-17-248-215.retail.telecomitalia.it. [79.17.248.215])
        by smtp.gmail.com with ESMTPSA id x64sm1166853wmg.33.2020.10.27.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:18:06 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:18:04 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vsock: fix the error return when an invalid ioctl
 command is used
Message-ID: <20201027091804.7mpad5yaxzfmbva6@steredhat>
References: <20201027090942.14916-1-colin.king@canonical.com>
 <20201027090942.14916-3-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201027090942.14916-3-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 09:09:42AM +0000, Colin King wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>Currently when an invalid ioctl command is used the error return
>is -EINVAL.  Fix this by returning the correct error -ENOIOCTLCMD.
>
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 865331b809e4..597c86413089 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2072,7 +2072,7 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 		break;
>
> 	default:
>-		retval = -EINVAL;
>+		retval = -ENOIOCTLCMD;
> 	}
>
> 	return retval;
>-- 
>2.27.0
>

