Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F5E281A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbgJBSCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:02:07 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC190C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:02:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y74so2455879iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h8V5q3hBBM9ppuZeH/Xy4eNROVtwo5GE81zegwvnGnU=;
        b=S3g768h/qg61UFIr+oXtHH+4E/6og3mNqo0DzY618HZdzG9+E+pOIMs8FY/yQSHfhC
         8hFXjlHsMLLU8LLJKEsnvl5mBJlvgqtOp4YZu3+6XR2+e86NVI+LZw3+PgpOYCapuWwn
         xc6ofjLibNIo5zvKW3/Lt0ryeNESWVDyJRh/icZHho7fc5/F/2hdAxxe6O4UEiZ4Y3WK
         5dQWiO/7wFRkEektG/RXn82qMl9uXgtztS7gA5YXbAQctoNYzmR28uLqptsT/vfFir1F
         0WmccWdhDizKGm/b54nvHbmToZbtPyotVBhe8ObcAsUDfieur9U+6eacMaTBQwTSFnUV
         qbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h8V5q3hBBM9ppuZeH/Xy4eNROVtwo5GE81zegwvnGnU=;
        b=d1porBdRNak2qDAAQhdPdjlb4Ug3FLepUsMGie05z2vd/Kb+UkU2QD7+4+ovifLZMu
         4xvp9wx2vaqi4jtudIkLFPePDh7fMhOfOxLrZF7g1plODuJKdj0XOsCg7c4iOw7QKJFD
         UVxM83ptjjnnQy767SLy8FUJiz0a8UfjXVl981hnjcYH5Nmh/sp7bQ5f5mA80yVOh3QH
         645+PyEke1Rs9M/CPzRGDErqrwUg0lg33/uYFTtbArY/fhwr9VXP7/GA9m5Vs1BCihxq
         poGkhF922ycKmqGiq+Oa8f9GKzrS4N0q/jyYifqvtnbvwa1NJ1BUcWd233QrV4/cdPOP
         karw==
X-Gm-Message-State: AOAM530qilInq25wyI5/7sZk7S7wQmz5oiSrfjVgTPiaRbEmj4+G0sRM
        0RpE6zGPVvdXcyplifKr93pQ7v33Jk0whA==
X-Google-Smtp-Source: ABdhPJwavZPyjCsEMgucy9HCbyMFL6IkNC+opMYPqy3LtDW9qjuur+mPiu2YegnxGZ+dir2bwGhDBQ==
X-Received: by 2002:a02:8b:: with SMTP id 133mr2332650jaa.46.1601661724723;
        Fri, 02 Oct 2020 11:02:04 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s23sm994865iol.23.2020.10.02.11.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 11:02:04 -0700 (PDT)
Subject: Re: [PATCH v4] block/scsi-ioctl: Fix kernel-infoleak in
 scsi_put_cdrom_generic_arg()
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        syzbot <syzbot+85433a479a646a064ab3@syzkaller.appspotmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        glider@google.com, Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-block@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <000000000000a24fa705ae29dc6c@google.com>
 <20201002142223.9482-1-yepeilin.cs@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <afa31e81-84d9-fc54-e6cf-a8301f1cf33a@kernel.dk>
Date:   Fri, 2 Oct 2020 12:02:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002142223.9482-1-yepeilin.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 8:22 AM, Peilin Ye wrote:
> scsi_put_cdrom_generic_arg() is copying uninitialized stack memory to
> userspace, since the compiler may leave a 3-byte hole in the middle of
> `cgc32`. Fix it by adding a padding field to `struct
> compat_cdrom_generic_command`.

Applied, thanks.

-- 
Jens Axboe

