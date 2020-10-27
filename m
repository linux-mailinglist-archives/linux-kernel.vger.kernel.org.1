Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA829AD68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbgJ0NfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:35:04 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:40979 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbgJ0NfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:35:04 -0400
Received: by mail-il1-f177.google.com with SMTP id x20so1498762ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rXqxuhCPhInDJFWMwIOJySkG+GwelVIGToJrk2cMB18=;
        b=fUAGAyTsFkZOo34w1RJd30qc33lBq6mgjy75wt8giheCNdkRN8fhcfu2ixO0WSP/ZD
         xz//LGxwt3B+bxU5kToi0HgT3LKJQF1D9Hqg1v00W9F/+N1il/j1DIemFKBbNw6GnV50
         59zNnum0+eVt5pMQfJQmoCRd3jfZ4slJqrvfpOu5owdjq6stvPBTt0qS0WIV6/wNzfgR
         Ww2DcbruLzZC+DQphnM+8x7fUNEOI36I+uYy0XHOYL2xwOTneL8VWpBZL0PZC5kboL+G
         TI4AfBJuS9sdALwz+FgwLqoN4KcvxrmWtQIZrC/iEfaWNhtwV4j6jRSGuqSlQh7LmsM8
         LmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rXqxuhCPhInDJFWMwIOJySkG+GwelVIGToJrk2cMB18=;
        b=H4x/QeK5Czl9EWbUq+GX6JdnWtVmwmQLPLQkJgwi2bsVB0HhlDtB/D3I/Kj24XDwlF
         Shgu5j3FUe3o2A6bsSfHZY3Yhniv17mMR5aRojmsCSI127/L8J/YVAQV+RCHO07qJZ3L
         XM35Gru1TT+oHE16qzcerke+Whimb85AbExZaFJrap5AbyAmfonl8+XdNHznOQMBQ2gp
         83fwhKUaK/NWuYzLp+OxXzBzgymVnzuAiogWH+hJZVGkt7ORrNGXdDaH9BzjhpmoiVOJ
         wbrcad8I2npzHmIunxug0UIMQhxQyNHdMS+4xlzYQBfkDc9iySLsjxYoq5zj4TrOLK1q
         xWMg==
X-Gm-Message-State: AOAM532dtj05lwpOYeYXYSBNkqmWn+RaBOmzA9Og9D19kHtDt64u7wdK
        6fEW0k2Utxcz+f8ZNVswLtdx4ODc4wnE7A==
X-Google-Smtp-Source: ABdhPJwa1/KUPLFMW7T9PlmRH/3K5oKDpxdIOfmOJKQnhLpI6i7I9eT5ixf16Qipiuy7WkY4DWrixA==
X-Received: by 2002:a92:3590:: with SMTP id c16mr2029804ilf.286.1603805701310;
        Tue, 27 Oct 2020 06:35:01 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 186sm1057735ile.4.2020.10.27.06.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 06:35:00 -0700 (PDT)
Subject: Re: [PATCH] io-wq: set task TASK_INTERRUPTIBLE state before
 schedule_timeout
To:     qiang.zhang@windriver.com
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201027030911.16596-1-qiang.zhang@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc138db4-4609-b8e6-717a-489cf2027fc0@kernel.dk>
Date:   Tue, 27 Oct 2020 07:35:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027030911.16596-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/20 9:09 PM, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> In 'io_wqe_worker' thread, if the work which in 'wqe->work_list' be
> finished, the 'wqe->work_list' is empty, and after that the
> '__io_worker_idle' func return false, the task state is TASK_RUNNING,
> need to be set TASK_INTERRUPTIBLE before call schedule_timeout func.

I don't think that's safe - what if someone added work right before you
call schedule_timeout_interruptible? Something ala:


io_wq_enqueue()
			set_current_state(TASK_INTERRUPTIBLE();
			schedule_timeout(WORKER_IDLE_TIMEOUT);

then we'll have work added and the task state set to running, but the
worker itself just sets us to non-running and will hence wait
WORKER_IDLE_TIMEOUT before the work is processed.

The current situation will do one extra loop for this case, as the
schedule_timeout() just ends up being a nop and we go around again
checking for work. Since we already unused the mm, the next iteration
will go to sleep properly unless new work came in.

-- 
Jens Axboe

