Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB6D2ED3F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbhAGQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbhAGQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610035761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXoJUH9nb/5s3OhI5AP+cCvXW3KV/5X1dm5BDpD0/j4=;
        b=AzfKj/3T+VEBxUQl08yicPZ9nfmtZmnWHnPnuoUMJruT9PhjzBppwR6bk/on5Y0CqJi8kR
        DyYm3YqX4R1k0ewh8dRRKxxNvdYak5ii3XFaLzcTujbiqcEKyr8VTNh/RBSPIEIt796u1n
        bSOQ3UU/1GJ6OzY0MYzGfTuuw70taaQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-iI3JzWNuMB6Lt9LFsaUGgQ-1; Thu, 07 Jan 2021 11:09:15 -0500
X-MC-Unique: iI3JzWNuMB6Lt9LFsaUGgQ-1
Received: by mail-pl1-f198.google.com with SMTP id c5so4231207plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cXoJUH9nb/5s3OhI5AP+cCvXW3KV/5X1dm5BDpD0/j4=;
        b=gwkS3hNvY5FmmFAtG3cL0jzHudKxMIYnFg/khCT2C0kmxm55N3HfWM8B5wxk3RlsUf
         g660mJwgIJVmx6xYB7Z9Gw+wz0Skk+0dqDzt2/IICKhSt+oBloGfyjlVqIoA6g9VzBoC
         NG9jnGj4hBARhLZc0dJg0NXGsP86yptx03XY/ys2xSMYk4oAS+qkxKVbLmCCGtuBbmYG
         TNgloKwUC+s0RbnoVRuUNoROqx5KT4F1anrgGE8jRQOq+bzluWWoGgn5WLWUcbJEVH0M
         nkIZHbFmXQdP+oR1GNQoM2LlNQV7BTFNfTwoak/2Ngk3EVM54iSNCXsAvJX7MgYgD3G4
         eL0w==
X-Gm-Message-State: AOAM532dhrjofYul5AdNPev5S7koFyu94sYu4ToBK922FhmGH2kyAj76
        6E04wkCFbooY7qnJNnqSSTvuS1Uux8T6ub+LKMto4sceevOipfTYndbjLyWn7l7FtfyxXlEaSU4
        CfyB49iYCmDKIqGJU6e25CK86
X-Received: by 2002:a17:902:aa84:b029:da:f114:6022 with SMTP id d4-20020a170902aa84b02900daf1146022mr2763327plr.46.1610035753861;
        Thu, 07 Jan 2021 08:09:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW1DtzbZben3b+C+8kukp3vOiFY8Eplbbo86mLqsB8eougaXGrrkDWq3GjEDVVOFhveSFc9g==
X-Received: by 2002:a17:902:aa84:b029:da:f114:6022 with SMTP id d4-20020a170902aa84b02900daf1146022mr2763314plr.46.1610035753663;
        Thu, 07 Jan 2021 08:09:13 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i10sm7017924pgt.85.2021.01.07.08.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:09:13 -0800 (PST)
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
To:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        moritzf@google.com
References: <20210107043714.991646-1-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
Date:   Thu, 7 Jan 2021 08:09:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210107043714.991646-1-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/21 8:37 PM, Moritz Fischer wrote:
> This is a resend of the previous (unfortunately late) patchset of
> changes for FPGA DFL.

Is there something I can do to help ?

I am paid to look after linux-fpga, so i have plenty of time.

Some ideas of what i am doing now privately i can do publicly.

1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.

2. an in-flight dev branch for the outstanding patches 

Tom


