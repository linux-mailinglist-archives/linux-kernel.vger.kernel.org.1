Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E5E1C6AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 10:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgEFIIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 04:08:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27356 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728345AbgEFIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588752513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CBWxp/RqrAZHRhIdtBhb3xri0XLzwh+Ch7QU+ftNF34=;
        b=X5aij9Dcg2c93UiXjCx3F/VgGLUlK7pOUCYpH/bYM3QYiDkBSGh0H+oceIGQiF7O03vaEV
        tAM8Jk8uRuPne4OoGVMRylpzKyTsqwfgTWG3njDnYngWMNqaZ2x5ZG5UaL+8YXkyqaIw5v
        GGwZCsCSe+cvN9YtNFcYgdbqxo+4S5M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-e_77Q8SLMRGJkrACzdZ5ug-1; Wed, 06 May 2020 04:08:32 -0400
X-MC-Unique: e_77Q8SLMRGJkrACzdZ5ug-1
Received: by mail-wm1-f70.google.com with SMTP id q5so787592wmc.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 01:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CBWxp/RqrAZHRhIdtBhb3xri0XLzwh+Ch7QU+ftNF34=;
        b=eW1AXyYQgISw3ms2BqjiOMhV+ad7ze5GLRhWxoK4Woesyro+8sdFetBACiSpd43DZp
         XhBL7k471Kp6NP/AmXpWGnYJzJXWN18Sx0LV43DBGc4FCE6YJwx9wdGwCrDAJKkpd2+a
         U0RmVMxfjDuffxuPWMAq6RDHASujOtz7GvgMpx44hSGp3fxrxIpuySpqo2cWTAW6f+nk
         HoQ0/1qH5rcVCgE9JYs6pGeR+owS36ayFZReYZ2LEt6HyXPPG7N9MTI/jm1WEdsqyqEN
         KJKKgMJHS9ZO9YwFbbdVQlUoRy0OGuVcOr2AxC1mFzbexolqumJvpG1EtjN5fZqCE4aM
         1nqA==
X-Gm-Message-State: AGi0Pua7wW61eX6OeX18OLpscphouBtKlr9S+Hronp9xQvd9aLu+jMbE
        3vBWiQIZNnmYDih2BXI685yjrK9YTVRocLMGFv7ddlC7Dqxn49llTHt46pyVEjDcM6yFd1K/yYb
        UQ/XEm/lgwvZ002gvGKx0odUB
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr8713636wrv.73.1588752511065;
        Wed, 06 May 2020 01:08:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypKoYFzRFdcs5OUqDOntDuXyJrKD5k/C6ihqMqcjU/DctdS4/KReL94LfbKFGzcZw7Aen1K6xw==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr8713617wrv.73.1588752510881;
        Wed, 06 May 2020 01:08:30 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id g25sm1724902wmh.24.2020.05.06.01.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 01:08:30 -0700 (PDT)
Date:   Wed, 6 May 2020 04:08:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
Subject: performance bug in virtio net xdp
Message-ID: <20200506035704-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So for mergeable bufs, we use ewma machinery to guess the correct buffer
size. If we don't guess correctly, XDP has to do aggressive copies.

Problem is, xdp paths do not update the ewma at all, except
sometimes with XDP_PASS. So whatever we happen to have
before we attach XDP, will mostly stay around.

The fix is probably to update ewma unconditionally.

-- 
MST

