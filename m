Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406682F85B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbhAOTrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAOTrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:47:39 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F987C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:46:59 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c12so6132268pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9IS+fh6MCCDCQ+BfoHMgSQHNOfm3cetsFO+rC6C5274=;
        b=Le8m23TktCJjQcyjzWK+AzoEqUymSnXQH0TGSWHj0H9QI/J9T1cKJ/aVlCePnNjPVT
         Y1upeweTuwAAT5Kg8l9ogRFnjDKSqa+TlRBlrFjF9n/5ZN8gEpp8vIJTdj3eLPqiUwp9
         6ebXzVwz/0Omd4u+9JpKROdCjIgjs8jjd9IYUumNhwy3XZhKpy0JhgANIJAfRD9zTO3J
         QdanttIXFDSoPNWqs67alwleppb1TAiKZlzDzYmhLyAe48kpNdyG39dLvePpgxJ/S2RD
         BS5nI7u07E10+OuO9dZMlsltlDWsRcLHrGQGlvD3HIm3s8DI+1ryplsQvS+vsIDSTdbn
         Q1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=9IS+fh6MCCDCQ+BfoHMgSQHNOfm3cetsFO+rC6C5274=;
        b=TRWxvK6uzh4lhoZoZ6FSmNyF+IN9kzO+eA8uO077uTw4+zgRwx7wRvx0IBZ9raBHeR
         sZvfXftSMO3FXZLoBJx3Rigiw42b2VhNEfE/sAItvRnK1ETHg0dTR8E7OGEurlI3/DHJ
         UoVJoYBOS/1rZk/JpyxTf3D3GEN4cWURKvrq19c5EbSVJYiIbSUvDlFSIxHHg0Rizair
         b6ruTQsymksSv8Xe7vIwYpkSGCdox1ypsghPazMpsxaR0Yuo9rWyv4L6PbL0uLuI1cWD
         EgY8UXjaQk/XHue/qF20xyV/LUo5qBiEgxnmSsD9uxBAwYLTrpyFdkfNU2JVvetN4NW9
         uY0w==
X-Gm-Message-State: AOAM531Xx7r3iSLe9rPL8st1Xv+2qg+Rs5B0SdiiOSg4j4eV0sm6Mf5S
        cTAOIze7dHjW0TVGyXZLBiBe2w==
X-Google-Smtp-Source: ABdhPJydHMf/r4or48M0HNd5ih/mIUSrAuYH2SfZS56OrDuTFKCTsE0iuPt8bLggTkXsvNrNclpDew==
X-Received: by 2002:a63:c441:: with SMTP id m1mr14019406pgg.353.1610740018660;
        Fri, 15 Jan 2021 11:46:58 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id g6sm9237850pjj.48.2021.01.15.11.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:46:57 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:46:57 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Tang Yizhou <tangyizhou@huawei.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2] mm, oom: Fix a comment in dump_task
In-Reply-To: <20210115142314.12903-1-tangyizhou@huawei.com>
Message-ID: <3cf6fa69-9a10-36c1-ac6c-358165c0b7bf@google.com>
References: <20210115142314.12903-1-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021, Tang Yizhou wrote:

> If p is a kthread, it will be checked in oom_unkillable_task() so
> we can delete the corresponding comment.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>
