Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCFB2FF4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbhAUTf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbhAUTct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:32:49 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09053C06174A;
        Thu, 21 Jan 2021 11:32:07 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id s2so542477otp.5;
        Thu, 21 Jan 2021 11:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LfhmXl44xyRFU1WuFEHPQ0m3AepnomDCVD98PJHzm+E=;
        b=oqJ0dPki/u4N8RSgbdC7agzTSLynNyW2teEzHHkGYsTFIBnBjKptDhzkgoyRYu0HBy
         6627BWAtCrpBnCn3RbOOzQXYj70tliZcMb+/q7FjiQ4vWJ/VcVPoA6hk1UZSDu+z+sxm
         5Ima8SbuKm14w7JgueMf9jSuSzhhVhbR+MNTX5OyQ+iVSfsK8avvtlBtGygY2D9bg9oI
         3LXT7B1FUP3W4hfZ8vO/X0gntmQfS1vralL5nIch7ZFBUBULYOMlJmGUrPlaO9ndOZ02
         hZHVj9C4jkWKI4VsmL1X8ZCwFzSU1TEBkafzlQzNU+WubfqJ4Vjp7LQcAeNorI+4F3Nz
         lb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LfhmXl44xyRFU1WuFEHPQ0m3AepnomDCVD98PJHzm+E=;
        b=XfMHN1VOA9KQXz6kCWgpruW1oeKWHZ5u1fAoow95FvJyFY+EU0WUQozH5/f1o7vSl1
         3gkvmUUZNDSg2AaGQes/Ld3j+2RCVnRJU5pHJTIqlCnPB1Qz7SBfvCA9wPyLRqozc8Pn
         yd7R7EdaDttDgnoyXexREndQqWQFTlXtAfdTrbyvbrhsZddc0/NASNiSgXJ1DUuTjJmX
         5ZXsZeD/wtzrrmbXOQkidf2YeKh29lRFVG4CHNCnMwomsFLUKf1R1XCZl6glFQmKdbLF
         1cZpwkG3xwea6LWj3M1ttYDwcbpt5QrhVy24Zwp564J7648nFQknZP4lfcO5xrfkmPRb
         sMGg==
X-Gm-Message-State: AOAM532ZGYcHp3e5Tf3dU2QDi2BCkKq6hiRI5xi57tsNt4aC8/n4Du3r
        5vF2g69SiT1sMU6W5CjBc+I=
X-Google-Smtp-Source: ABdhPJwKHD1aQ7a5gK+XOoKiDATLlKLwGVNI6a2oqd/bVcCKf/giI+G4Jg/5kp1SJ8OCWKACpbDfdw==
X-Received: by 2002:a9d:4005:: with SMTP id m5mr550497ote.120.1611257526519;
        Thu, 21 Jan 2021 11:32:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l5sm1250629oth.41.2021.01.21.11.32.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 11:32:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Jan 2021 11:32:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     rydberg@bitmath.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (applesmc) Assign boolean values to a bool
 variable
Message-ID: <20210121193204.GA31325@roeck-us.net>
References: <1611124870-125658-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611124870-125658-1-git-send-email-abaci-bugfix@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 02:41:10PM +0800, Jiapeng Zhong wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/hwmon/applesmc.c:568:6-23: WARNING: Assignment of
> 0/1 to bool variable.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

Applied.

Thanks,
Guenter
