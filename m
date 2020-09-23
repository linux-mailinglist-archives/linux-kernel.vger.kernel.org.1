Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A808275C60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgIWPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:51:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39241C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:51:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so511998wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d23JCe9YVCSwewaKJpHfEr18jk0UsqlTGJDK4s+v3Rw=;
        b=mLSDWzb9NJPkfFpJLhhNHFyDpbXfsn0u+Gi2GEYt3yC8Z4teBiwfazJzjSkDN8l6Eb
         yo17VcXcZpncc4TYAmx18hI6Rs/0XOd0Ku58uFdgKDSK/y11N5XQk/5FUcHUnQeUibRn
         LNNntWHLd/U/c3NmolD5LQtb6W9Ur9upQP65k2oPZ51OvyXw55CxtDlVHi6OR5qvGUOw
         N6J4yTpIY7s//o5l5W/zeL8wkXFqtIL5mp4uMU0EXf/T75Es8Pw/HNOE8sBXLpvHJ5ho
         uc8ZCpTYiz9i1QY5U8pLdl9zH1xg0CP0PX2Ew393KkuG+c1hIKqbwOr3TSVzDkEe1Ub5
         ZH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d23JCe9YVCSwewaKJpHfEr18jk0UsqlTGJDK4s+v3Rw=;
        b=iJ0O3FGx9ORJVi/1dMP6AHkCtXdaIBSdsc5Kog1/K32wZ9i3wb8HBW4T7nx+A0RcNJ
         4SOCCteIYnw+J7XMvdsOUcdrbCb/zHI6nn+bn6xIcp1xJxwJCVJyfNrzfj0Z+BKi5g4A
         iG9f4QNkgIosvUdamQW2eZ5eQMdwmMDdK1CVocyAcMtiUqEmNnvnDflQ7GcDGZ847f4X
         Mmj6tXQn5AZubY3+tzIBcUT1fcXLmk65gmRLb9WC7p+1L7YxRy4DITPR5ymJApzRWogE
         0eTlK2VSfJ0fCBoXxvzwRFMEE+QXylLoy6AfIQixcVmxdxZGsWSB32kawiOluU3ow20X
         rKxA==
X-Gm-Message-State: AOAM531dCx1z461HVR4VFpy82XYBgssvcTobKEU4XfjldRuevXk7q83O
        Pf4j80NcH8JTEyJKveXDtTnCgqXqP2PL2w==
X-Google-Smtp-Source: ABdhPJyoL5IcxAMDCJdQ/xz/kahFpX9Ov5SbPTDtruFxXn24C58ta6XhcyoXtQkoQAJE8hjfh1fPsg==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr243276wme.102.1600876268343;
        Wed, 23 Sep 2020 08:51:08 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m3sm183582wrs.83.2020.09.23.08.51.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 08:51:07 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200923135343.16565-1-vadym.kochan@plvision.eu>
 <7a072204-a4b8-e5ef-9ce2-4db176f70366@linaro.org>
 <20200923141334.GA16798@plvision.eu>
 <1f65dc6a-50f3-d4e5-f1ce-7a68fddde287@linaro.org>
 <20200923145107.GB16798@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <19c5fa23-41c9-f5c7-beaf-aeb9655bfefd@linaro.org>
Date:   Wed, 23 Sep 2020 16:51:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200923145107.GB16798@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2020 15:51, Vadym Kochan wrote:
>> -       return nvmem_cell_write(&cell, buf, cell.bytes);
>> +       rc = nvmem_cell_write(&cell, buf, cell.bytes);
>> +       if (rc)
>> +               kfree_const(cell->name);
>> +
>> +       return rc;
>>   }
>>   EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
>>   ------------------------>cut<---------------------------
>>
>> --srini
>>
> But is it really needed to kstrdup(cell->name) for nvmem_device_cell_{read,write} ?
This boils down to if we want to use same api to parse nvmem_cell_info 
or not!

If we want to keep this simple, we can either explicitly add free for 
successful caller to nvmem_cell_info_to_nvmem_cell()!

Or

use something like what you did, but new api needs more clarity!
May be renaming __nvmem_cell_info_to_nvmem_cell to 
nvmem_cell_info_to_nvmem_cell_no_alloc would clarify that a bit!

Also can you make sure that linewrapping on function names be inline 
with existing code.

Please send v3 with that changes!


--srini
> It is used only for log error in case the unaligned access did not
> pass the check
