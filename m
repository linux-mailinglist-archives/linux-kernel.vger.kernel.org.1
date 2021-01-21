Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C442FF452
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbhAUTZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbhAUTYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:24:33 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E916C06174A;
        Thu, 21 Jan 2021 11:23:53 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j12so2259380pjy.5;
        Thu, 21 Jan 2021 11:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yiY7HD46FUvTU9Oj6CSOT7lbeUEzegOMDCYKa4T7F94=;
        b=Z5XiKLNwDOfUbX/CovSxaboSwcc188M6BVytHUDexBth6QFlcnD5g1k4HK9xyE69U3
         LVu/SPf9QcFY7885bLrdrcCFaOxTAAUFkWpByOPaNTCA4P3Z8IWcIqUB6RNQZaiZjax2
         82cgY9Ry6x1W1+CPCBOqJ+wsxw6yarxPoKI4UlBaIu2uD5MeuAo+xqC0qlW03GYI6Uq3
         MLkiYkzx11ASlkIH5DnVlZbL83eeWwR9LDx0bpDd7lviKlQfpNIcC2CyqngHxNG00Bwv
         NeaMnLJhSUvr+o1rxaHqX8IUyjEf7Q7G8juZ8cu38zGgDWMIIS6Rbq/qzygYo30I2WVM
         RRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yiY7HD46FUvTU9Oj6CSOT7lbeUEzegOMDCYKa4T7F94=;
        b=opUMVKqe0TUZg28QJRVaUymy5kQmHRhWeqiSp8hZwcV/y6uptLK5KStD2z789wZz2A
         xaIyJ2PUfpbmcS5NiwmV86dkBnF7VEY7+JdIp/o+4WFsLEjWMzZeH0t7VGQVVj0DVf5n
         MwCFUCzRvKRKmRSbAPtN2fvKpPa9EaTdIwkQhVasF+g8D2/+OZ09iu3fYZcWo5wbE/U7
         i7Sy3UGAVb7aRKGyI95gryKx7EXIdqXCagYJ/TtJTn85w6uZVVdY6VfvelegzQbmiE2z
         CxAK++VgKeDaCWzTmld8J0ChJWdhl8lgyANy0fgA3WVzi2nlzG21JcnYW1BQ8btl0gfy
         xZMw==
X-Gm-Message-State: AOAM530AJBALIawd/2qdqVnBmQvjXlxBnj+03p2wWK4HAHxVGKyRSfMB
        mTQndGnGk4Sw4Bsb26c++j7POJm+oS0=
X-Google-Smtp-Source: ABdhPJy1tIhNY3xUiRniEpUrqJK1i7hcf9RFMz6Nv1JgC1ejFXtwfrgX7yX6kHVQbn0QSa3gxct6wg==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr1015256pjt.144.1611257032397;
        Thu, 21 Jan 2021 11:23:52 -0800 (PST)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id r14sm6783315pgi.27.2021.01.21.11.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 11:23:51 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: stingray: remove sata
To:     Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210120185140.16929-1-scott.branden@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5430df77-4364-7cc1-48dc-a335ca4c409a@gmail.com>
Date:   Thu, 21 Jan 2021 11:23:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120185140.16929-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2021 10:51 AM, Scott Branden wrote:
> Remove sata from stingray as it is unsupported.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Applied to devicetree-arm64/next with a slightly reworded subject and
commit message along with Ray's acked-by tag:

https://github.com/Broadcom/stblinux/commit/142836ca820a7ad3b397bbdda7c35971f4b9772d

Thanks!
-- 
Florian
