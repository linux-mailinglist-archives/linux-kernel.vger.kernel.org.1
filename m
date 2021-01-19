Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397A42FBE66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391533AbhASR6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:58:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbhASO7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:59:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F8A120DD4;
        Tue, 19 Jan 2021 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611068294;
        bh=L60KYqMQwfm0ne0TltV38hPXkFcoWAsd13jc6AI1Pf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOE4TBNsMeCowfuGT+DEUPtXXmRivlzIRV15sF/st+1cQ8pTKEDYqD6mqlJChJWeB
         BSYdEiRIjzM1yJFIxZzdbMikw0esJR70VA/6fI4ICobwQsWOTQ6AtwLOWPToJ3AkJp
         93SmktmT5I48MUSuYv4yfeC+5O9dIvpC6rFdZmRxTZ0fX/k2fOd9112TFIjQ+ZGZHq
         2qWxi+K/3wDO8GXR82mqE3D0mK9pW4xsxtjlmdn33g1UrzP9nA6SxEUzhFJKoes8B6
         qAVbxJp3JiUyO2mvdAvP9SmVO/mwt7RcyJfDKfngGxOoxH8FNRt3yPaM4OyXlTD8Tc
         MR0mD3RdpyX9A==
Date:   Tue, 19 Jan 2021 20:28:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/5] soundwire: fix ACK/NAK handling and improve log
Message-ID: <20210119145808.GW2771@vkoul-mobl>
References: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-21, 13:37, Bard Liao wrote:
> The existing code reports a NAK only when ACK=0
> This is not aligned with the SoundWire 1.x specifications.
> 
> Table 32 in the SoundWire 1.2 specification shows that a Device shall
> not set NAK=1 if ACK=1. But Table 33 shows the Combined Response
> may very well be NAK=1/ACK=1, e.g. if another Device than the one
> addressed reports a parity error.
> 
> NAK=1 signals a 'Command_Aborted', regardless of the ACK bit value.
> 
> Move the tests for NAK so that the NAK=1/ACK=1 combination is properly
> detected according to the specification.
> 
> Also, improve the demesg log to get more information for debugging.

Applied, thanks

-- 
~Vinod
