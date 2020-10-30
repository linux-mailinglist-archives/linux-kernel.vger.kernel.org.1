Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F88F29FB5A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgJ3Cev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3Cev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:34:51 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DE8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:34:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o3so3916751pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XC8QFIrJRI23iXvNAydpIbJLUt3i5oKfDIDL6c8cn1w=;
        b=nmYT9va+NzaA6EfmzMl+DcgzMc/Rj0hJCfGP25NOocnKBhsGcbZwYlVVFeMSpsuyWh
         gnQri1MUjSH1Yh7WdY53i/pr9AOPf/SnRtejOe5sy747TsLvRoGmhvWh8cl3+f1dYFvM
         mlOSuk5aGGOQGBwc7IkiWKF5YzDUE4U53ggXdKffvqxK77vdOws19ohAopxfvGaF/iMS
         0inYCFYpMIEPPbSzxyZT9lZJfV60qS8Zap1WbMQN+n1jLKoU5ZWQdtBZ+sPwTY6VMNIC
         Dc7nzsWSCJXUxcOTvI6pTciVaCTY8SbZYgmjGnQTBMpZR1kD26Fh14qFQY/irUPr/Lvk
         VnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XC8QFIrJRI23iXvNAydpIbJLUt3i5oKfDIDL6c8cn1w=;
        b=joCqSIO6gA28MkCcmcpFmEl37wA7IU3iwUYLGzbsN/2tb4wViQ8EA/RwDpa8o+vKYX
         Po9Sxi5LnEP1DIKM3KvwUOJTcAq/Zrf9S29Ql86CzWwRVio8b/3s6h2QitabDUXzgPTz
         yImTzcurRgVlA+oADi0s7u+SYYJwI+Pf88a8Q/lL5OCj7vyxg3t/VJcMdFp1QwXt7QLV
         xtEHA9TnPzZEnOeU8WJrENfV0xSxohJ3M3Q9J3aTrHemVbTyJM7JmwLPIZyFy5Csq8L4
         aA82/mpRtE3v4/xQQE8ORZw0lXKHo2N4lxYtRttRqLwqJG7FhnV6a1bZ551rw+XvhEir
         ACSA==
X-Gm-Message-State: AOAM532PzcuPIxiSHi+LRF8tUYbL8IYCfYY33PGh8MvwlkWgQlUNXNxC
        0rHI0vXsMcq8EYa97M6MhvDrSa5nP+Q1jw==
X-Google-Smtp-Source: ABdhPJz8PNzaKU1/MMBJlFaTjC7ar9fGlvVQKis6CWQL5YSbfg5gqNAqj4zfbpq9ZbFkIfVutn6k2g==
X-Received: by 2002:a17:90a:4894:: with SMTP id b20mr161194pjh.102.1604025289258;
        Thu, 29 Oct 2020 19:34:49 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id kv19sm1237454pjb.22.2020.10.29.19.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 19:34:48 -0700 (PDT)
Subject: Re: [PATCH] nios32: add support for TIF_NOTIFY_SIGNAL
To:     "Tan, Ley Foon" <ley.foon.tan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c6e927af-7ffd-d087-8716-729e87d80fb1@kernel.dk>
 <BY5PR11MB389300779C8CF5D2B5196E1BCC150@BY5PR11MB3893.namprd11.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <385c384c-187b-4b92-c8e2-125788dd1e6d@kernel.dk>
Date:   Thu, 29 Oct 2020 20:34:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR11MB389300779C8CF5D2B5196E1BCC150@BY5PR11MB3893.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 6:27 PM, Tan, Ley Foon wrote:
> Please help integrate this patch thru your git tree.
> 
> Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

Great - thank you, added.

-- 
Jens Axboe

