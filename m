Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A974A270AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 06:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgISEur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 00:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgISEuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 00:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600491045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V/GtNqeAhxmnaYHKbHI9s+9A7kWQV4YD44WjAsjMMwM=;
        b=KUBRpPOIEVeoQhtimD41JCXyJKfzgW8CpwzCESrq0MplN8ww08wsEbW5EG1TS6MbzU8/9a
        bSCKsmEHlO0TMuiWxzpZs50eR/LQjR1kMSxY3GE5TKrLM+O/Y1rpaRTPJXiX9NNzYSrJ6j
        CyGsv41AWERgEYbQ9ve+q2mgSonEbl8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-55LgYvViOtCkYV2YvF5m8g-1; Sat, 19 Sep 2020 00:50:41 -0400
X-MC-Unique: 55LgYvViOtCkYV2YvF5m8g-1
Received: by mail-pf1-f200.google.com with SMTP id q16so4921150pfj.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 21:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V/GtNqeAhxmnaYHKbHI9s+9A7kWQV4YD44WjAsjMMwM=;
        b=EhGGqOQVx1k34QP558qI6fgk9dnvDOfGM1inD1ZKu2nda27dvcEcFyvbsjv2ITZ+20
         Aowl7E2Gt2gv0nn7r7paJuNXwZ8KhaSHBHXczWTK5jqkP3nWIMBf3VddkPgG8OSEHQYW
         QKuMJQcDay2w6YCq/NaQsAwcVWjjF2tM6fCE6G3l1DSxqJE88RSdBbstlRe3GRpuWPBk
         S0wcqTwwiaXgkHEKiuWUIVMVeSHZqo+4eR9jtiH+2OXCt+8tQLI/5v1IT8WZLkUHORNx
         9DrM/uxRyRH0gWLsUMFLKSEVe33oSxgmjjx6gdrsxZAqfpYOYZ0rzpYtYJLEg8RIkFw/
         hBzQ==
X-Gm-Message-State: AOAM530NFZueJrJxXfpYf8qnynwcf78OPxmPA1GqvHvDl6J0F+JOGfiV
        67W0xF93ntU2UBtVjuWF3ZnWWd0sUYqcrjWZeffOcoLEcyDUzClX8UNoXB0whBSRYNHalquyPXs
        YCs6HN1rz/uAezvOawWjvUySy
X-Received: by 2002:a63:fa45:: with SMTP id g5mr28532849pgk.448.1600491040327;
        Fri, 18 Sep 2020 21:50:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvVI0r49m3wB0RYWnXgFPLiK9pU7OtGbcH6Hw1jnUOf70rw5kEO1Odeu56Qv8mcOKhwwSI1Q==
X-Received: by 2002:a63:fa45:: with SMTP id g5mr28532835pgk.448.1600491040079;
        Fri, 18 Sep 2020 21:50:40 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l188sm4898305pfl.200.2020.09.18.21.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 21:50:39 -0700 (PDT)
Date:   Sat, 19 Sep 2020 12:50:29 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 3/4] erofs: specify accurate nr_iovecs for compressed bios
Message-ID: <20200919045029.GA18633@xiangao.remote.csb>
References: <20200918135436.17689-1-hsiangkao@redhat.com>
 <20200918135436.17689-3-hsiangkao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918135436.17689-3-hsiangkao@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 09:54:35PM +0800, Gao Xiang wrote:
> Use more accurate compressed page count
> instead of BIO_MAX_PAGES unconditionally.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Found by ro_fsstress, the submission chain could be extended
by other threads, so this patch wouldn't work with the tail
merging strategy. Please ignore this and I will drop it and
send the next version instead.

Thanks,
Gao Xiang

