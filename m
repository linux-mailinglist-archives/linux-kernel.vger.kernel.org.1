Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4FD2705C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIRTrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:47:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38654 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgIRTrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:47:14 -0400
Received: from [192.168.1.12] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id DABC520B7178
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 12:47:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DABC520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600458433;
        bh=BkCanJGy0PXFLPlnH6zom6LHySP8W9di/NMEUaviEfs=;
        h=From:To:Subject:Date:From;
        b=IHvL9aByhlUPH4sHgwxRk5++huiZeeU1P4uoFXOBlyOoKd0qu4r9aXbTmZbz0/mbG
         Y7165pvFoDOYytm2zAXLm6wBnXHzbBwL7aHn5cAnSuFrLjTVuKPq+Eh2MlTS7I4WQW
         87gGSmx61KXxRHWYOCyIyLi8fWdYcQeRmE/6WsQI=
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Subject: How to extract linux kernel version information from a kernel image?
Message-ID: <b8e9ee52-c0fd-a6cf-3054-4220636a60e9@linux.microsoft.com>
Date:   Fri, 18 Sep 2020 12:47:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been investigating a way to extract the version strong from a 
kernel image (e.g., vmlinux). The version string I've been looking at is 
essentially the linux_banner symbol.

We'll use IMA to measure the version string on the kexec system call, 
providing a way for an attestation service, for instance, to attest to 
what version of the kernel is running on the client.

I haven't found a way to extract the version from the image that isn't 
simply searching the whole image for it. I was hoping someone here may 
be able to point me to a better approach to retrieve the linux_banner 
symbol value from an image or  any existing kernel code that does 
similar parsing.

If that matters for any suggestions, my current focus is on ARM64 images 
(if the code ends up having to be arch specific).

Thanks,

-Raphael

