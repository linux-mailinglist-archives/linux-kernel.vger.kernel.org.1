Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6609828DAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgJNIOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgJNIOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:14:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26182C045865
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:46:43 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p15so3032737ejm.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=STRPyXECWcKIltplEj2C6HgW45CdmUPVhi1h9K50BgA=;
        b=nwv5JrunBDQOJDnDy8DxJyuBzuA/Y7BaCN/OCMVqP6MuQLli+zyRmEEGAq060tbJI3
         f6pkpYhrqcFU+WydRQSYKm+iyJTTBYZ7KKMP37t/w821wgr0DJQdqKOKYMi6P7woG+Ry
         j9rv7cGtnS37rwibw7h+sR8h8NfpugEuSecPwDBT7W5wIokytyYCqBa4HDsDktpxsYNv
         pQLwRJ2EZ040dWCxujjuI+2cMU9Av40uZhEhLcwYbQm+cY7SBoSuvIA+dyWTNVNkNsBp
         56CdJUu9El1jynQGDU+icjSF+YSnevfGW6fvjc+YWQBZrRPXY5ZY/aLK9uWs07aSry9K
         FK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=STRPyXECWcKIltplEj2C6HgW45CdmUPVhi1h9K50BgA=;
        b=POYuu1bEBFdaTA1XWDoSObmC4YZ7Wf1OCAY50PwjNCAQS7jp+Vye+n+fGGFOhjxg69
         GLHgy+nPj9f/btg0xWzyywMuZEgibjpIWMlP1oA/8Is0NTWo5SbTUb6JIONgbGu1zFUm
         ZJFdZE3Lk2E7sFv8IdBB9+WZYotzFU2/i2kgPiKxFLu3g2vjt6WyNmHv0lR2rPS1ClgV
         cihD+yppMB29fyb5KN+m4cEsuVb6WHYc3Z47BdnYperUk9UevKUAdveArk3AVbNge1r1
         zzJhrzY9YnUYuMqsnONuc5z5zZLnyFoHzJk0uj3+sBfHqalJ/jED4B9XjgoIiVJdRRna
         /cag==
X-Gm-Message-State: AOAM531uDakJspugIhphnqo+qJkDhehjFkgYS64GQho4FWj2Rsq7CNnR
        p6MlnMpsutmJZNgnLIPgrpQ=
X-Google-Smtp-Source: ABdhPJxX/pHP+wB0Q0Rx87O0NVMkFbwJSOQsleVvEoA6b2DlvKbLJ28VuGQQ/GkvXeI8kDJVObpMSg==
X-Received: by 2002:a17:906:a988:: with SMTP id jr8mr3525968ejb.508.1602654401785;
        Tue, 13 Oct 2020 22:46:41 -0700 (PDT)
Received: from felia ([2001:16b8:2da8:8200:4c70:9c82:f3bf:bebb])
        by smtp.gmail.com with ESMTPSA id n4sm988978ejj.19.2020.10.13.22.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:46:41 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 14 Oct 2020 07:46:39 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Ujjwal Kumar <ujjwalkumar0501@gmail.com>
cc:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
In-Reply-To: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
Message-ID: <alpine.DEB.2.21.2010140734270.6186@felia>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Ujjwal Kumar wrote:

> checkpatch.pl checks for invalid EXECUTE_PERMISSIONS on source
> files. The script leverages filename extensions and its path in
> the repository to decide whether to allow execute permissions on
> the file or not.
> 
> Based on current check conditions, a perl script file having
> execute permissions, without '.pl' extension in its filename
> and not belonging to 'scripts/' directory is reported as ERROR
> which is a false positive.
> 
> Adding a shebang check along with current conditions will make
> the check more generalised and improve checkpatch reports.
> To do so, without breaking the core design decision of checkpatch,
> we can fetch the first line from the patch itself and match it for
> a shebang pattern.
> 
> There can be cases where the first line is not part of the patch.
> For instance: a patch that only changes permissions without
> changing any of the file content.
> In that case there may be a false positive report but in the end we
> will have less false positives as we will be handling some of the
> unhandled cases.
>

I get the intent of your addition. However:

I would bet that you only find one or two in a million commits, that would 
actually benefit for this special check of a special case of a special 
rule...

So given the added complexity of yet another 19 lines in checkpatch with 
little benefit of lowering false positive reports, I would be against 
inclusion.

You can provide convincing arguments with an evaluation, where you show 
on how many commits this change would really make a difference...

It is probably better and simpler to just have a script checking for
execute bits on all files in the repository on linux-next (with a list of 
known intended executable files) and just report to you and then to the 
developers when a new file with unintentional execute bit appeared.

Keep up the good work. I just fear this patch is a dead end.

There is still a lot of other issues you can contribute to.

Just one bigger project example: Comparing clang-format suggestions on 
patches against checkpatch.pl suggestions are fine-tuning both of them to fit to 
the actual kernel style.

Lukas
