Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECCB1E5B08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgE1Ijz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgE1Ijy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:39:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9026C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:39:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id bs4so22529179edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XDdmB/aDu7vmw0I5lDV1Q4+gB4BypwighQ3lORBH3wc=;
        b=CAf+Dz0VmWC9ztDzhIYSQC5YVbiHg299UsxRcMebMK3XVuQcskr9cr//obYizUBr+R
         SKVtD55+vPtxiw53ri8K5USs5DFmuFlSazeRgHvcrAmaaeDFhJ+uUJtwxZQnq+7B6oyM
         zWNmnMPBYfdRFb5U/GUekJn3HfUFhIrm4XixJSRFtA4ymOC7zXxK8WJ1BHqFmaae6lXT
         5Us1elbOj6TDt69XYXExD6KadgdBL4mBFR+6Aa96MYHUMH84S/tkiyI5vphWCawc22pK
         pe1eEI8Hp4dBVsvnANDTySVLCVBzOApuuVA4YBL8FRi/ElxKqW5yqqKIUBMAI6Szc5cX
         vk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XDdmB/aDu7vmw0I5lDV1Q4+gB4BypwighQ3lORBH3wc=;
        b=sMb1nLDZbGoBRDgZ6e/FYw9WpIIR+aEU/PmawSnszm8w+tkRa7j7CzcEcG2FlvFAwy
         dX9Je+gyb3X8gNG5Qfa8zf3N6zEQ2sj1V+ZOHItVaBw36ZVEiJNlIdIkjTIJ86jh2Dtj
         IYZ4DUonL+1NrOzbpi2QfwlSEjX0m2AGdcka0wm3gVwV4QVhKN0hXLRLMOZvAVFKoY+J
         EWzsz2h/89lqjMcYeAnev0P/ukCVe8/k+vNBRyFPWt9/78h4MwAI9eYfNYllTcv/T5MJ
         2SJm5/Y6h2sWNSiBfx/CbxN7+Eq69Z1i9hLIdmUKhLVqsgR23BY5JsSvX47WtNb8Q5gJ
         TMxw==
X-Gm-Message-State: AOAM532gQlfIfa9sjU4+WUSqwZNd2EQIO7h8pfg9r1cAMs7BCcwhPXpY
        z0JENwRyEoPAHnReBfvQUMEX+w==
X-Google-Smtp-Source: ABdhPJzvS0PuIZ3CoJAyjzLsVMlgK6IFKiAxLwcj9LsbX/47TMdsJOcP881ALFfWIKg9AldDIGqiIA==
X-Received: by 2002:a50:d715:: with SMTP id t21mr1892086edi.194.1590655191533;
        Thu, 28 May 2020 01:39:51 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4811:7000:e80e:f5df:f780:7d57? ([2001:16b8:4811:7000:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id r9sm4367835edg.13.2020.05.28.01.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 01:39:50 -0700 (PDT)
Subject: Re: [PATCH 08/10] orangefs: use attach/detach_page_private
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-9-guoqing.jiang@cloud.ionos.com>
 <CAOg9mSQ+nGCD-k2OwWWd6Ze_PAh3mhSOwYcLugD-SQHCb0ymWw@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <bd3495e7-1820-6268-1a5a-76f54421fb16@cloud.ionos.com>
Date:   Thu, 28 May 2020 10:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOg9mSQ+nGCD-k2OwWWd6Ze_PAh3mhSOwYcLugD-SQHCb0ymWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 11:54 PM, Mike Marshall wrote:
> I apologize for not mentioning that I ran this patch set
> through orangefs xfstests at 5.7 rc5 with no problems
> or regressions.

Glad to hear that, thanks for your effort.

Thanks,
Guoqing
