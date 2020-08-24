Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94492508A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgHXTBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXTBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:01:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89BAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:01:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so10035674wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdQ01BYoCPmw8R8Z00rskwW2KNNCfLcU9jRwV6Y3oLE=;
        b=Jo/n8f/8sT2IZ+RQoFGB9GMENzmK6MQdXt1FuRuVCZWROngZY4b53ZPyFbwj7zB+Tb
         JRC/T8o3z3xhgHXn8XQdE4uxvMlT5D10mvkTmpSv8HzHsoMONZ6G3R9503U1BrMRkiXR
         7GeFKOTV87bkkB1w9eQ4xHNPGCff+4Mo+HxQjb7K0BmL+czAzo17CxDmV1rU9x5/p1Di
         aKF8XaDrwswFGGnP0o7jABfO7CVx/bb5GPwKWDLnS9UX/06OYuVq5VuTsUl/WP99ukrc
         wt+fx0bA42yeS7f47JWGF865+/wvNCYmBWqJKIhsfhM0cuvHQR5hzWM/0iuznhUX7fF5
         O9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdQ01BYoCPmw8R8Z00rskwW2KNNCfLcU9jRwV6Y3oLE=;
        b=e+rpWzmZlk/nU7KqJA57yboPmr+eIftp4ySmvQWO7u+SvuigBOyyCY2+1YR994LAkP
         hYLpF/vsfeO3vcgP2N8jJImFVNE5uqLCokNyQ6NmocCfVIEO6qIQ4HOhwtae0TP2S+zJ
         8SxS37kP7fq9WPkjl1zap0CPxY9RTBw4f/CMJAVJDvy4n90vtkahC38gwTQvu0LgoGSq
         pwGsJGT7XXigaU6+AYW/W31P0WeDuAGoEok6vuIuLqxQfM6iD217su4yTMJ7RfiLHBZ5
         8nNRqli+kysD0dq1HXoF7ufSphznOVT6JeHrGdsJPvD+uxS0XZJEi/GjkY+oeZ6eR4bs
         +Tlw==
X-Gm-Message-State: AOAM531/xEcC13XI0VsULW33kP2hWH1dpjUQ8XrqRMMUBADwH8aW/pr2
        FN7s6dpfQ9cEwTasrx9U94Qke2/ipCojQ/bn
X-Google-Smtp-Source: ABdhPJzVvUy6pZx3R8VQKW3UFagoCxt/6r1yvhQT/F1aK33WZ4rvQDJTIiaPfFy5uqn6L2357joejw==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr7155290wrn.415.1598295669674;
        Mon, 24 Aug 2020 12:01:09 -0700 (PDT)
Received: from a-VirtualBox.Dlink ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id o5sm765769wmc.33.2020.08.24.12.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 12:01:09 -0700 (PDT)
From:   Bilal Wasim <bilalwasim676@gmail.com>
To:     enric.balletbo@collabora.com, chunkuang.hu@kernel.org
Cc:     sam@ravnborg.org, linux-kernel@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, Laurent.pinchart@ideasonboard.com,
        Bilal Wasim <bilalwasim676@gmail.com>
Subject: Re: [PATCH v4 0/7] Convert mtk-dsi to drm_bridge API and get EDID for ps8640 bridge
Date:   Tue, 25 Aug 2020 00:01:02 +0500
Message-Id: <20200824190102.44454-1-bilalwasim676@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200501152335.1805790-1-enric.balletbo@collabora.com>
References: <20200501152335.1805790-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuan, Enric,

Is there any plan to merge the following commits in this series to the mainline?

  drm/bridge: ps8640: Get the EDID from eDP control
  drm/bridge_connector: Set default status connected for eDP connectors

I see that rest of the patchset is already merged and available in 5.9-RC2. 

Thanks,
Bilal
