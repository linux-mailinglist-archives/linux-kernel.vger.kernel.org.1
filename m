Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE90C2FBE57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391937AbhASRxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:53:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389184AbhASOxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:53:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51FD220DD4;
        Tue, 19 Jan 2021 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611067946;
        bh=rw/mxQTxKjzM1IS9HMGj4yUmYRQZgEBUAvLh9y86vqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K74/TcaNS0ofDl+B4nzdtA6Wp4i05o78R3yak6X+99V6+bHJo9EY1HOJjgKicEOem
         H3hsbojZ68Eoz33O7jArZNyn94fqogYXFdGnHqYYrgHC7bbE0nwsvFMJQeJCqFCfv5
         zr0bhO3aXsyQq8ZmBEfa/uZ3aAOumXqb8eBIoiJfyClIK23k3F00ElUu2/HYxTf7Er
         0mM6CtNrc5oj2j9zwTjfCFuQOzXc6ep8fuifOOJu39B8l//hTf8dkTVtWYJQvL/yI9
         QiM7cJjwthPR6wvrBm3dqWhPAyDtPvYvzUV4EKjRRoFK9iAxI4SRdo1czmu6cG3wkz
         wP7tLP1Lv7kzQ==
Date:   Tue, 19 Jan 2021 20:22:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
Message-ID: <20210119145220.GS2771@vkoul-mobl>
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-21, 16:25, Srinivas Kandagatla wrote:
> link_id can be zero and if we have multiple controller instances
> in a system like Qualcomm debugfs will end-up with duplicate namespace
> resulting in incorrect debugfs entries.
> 
> Using id should give a unique debugfs directory entry and should fix below
> warning too.
> "debugfs: Directory 'master-0' with parent 'soundwire' already present!"

Yeah id is guaranteed to be unique so this will work.

Applied, thanks

-- 
~Vinod
