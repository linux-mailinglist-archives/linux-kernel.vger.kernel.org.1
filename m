Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7262E348D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 07:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgL1Gp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 01:45:59 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19778 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgL1Gp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 01:45:59 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fe97eff0000>; Sun, 27 Dec 2020 22:45:19 -0800
Received: from [10.25.99.38] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Dec
 2020 06:45:16 +0000
Subject: Re: [PATCH] ASoC: audio-graph-card: Drop remote-endpoint as required
 property
From:   Sameer Pujar <spujar@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1607498532-19518-1-git-send-email-spujar@nvidia.com>
 <20201210021550.GA1498001@robh.at.kernel.org>
 <1fd0f074-c437-2b83-e395-d4b83ae49444@nvidia.com>
Message-ID: <7509fece-63e7-0ef5-f600-805568611b77@nvidia.com>
Date:   Mon, 28 Dec 2020 12:15:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1fd0f074-c437-2b83-e395-d4b83ae49444@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1609137919; bh=4RnmYt3XqY2jUc5jsEy8Vkzbm+pgY1VhzY/BC662sVs=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=EenvLDDfhd51IiylLBGfmwfDCXXL/DZBRWFTW17FAWzeuUWb8i8ut7aTiMN8GPoC8
         2V5RTCO/QSsZFmhx2qV22jRevWChKy7ceAvRyAvCPXw9Eid60xRTFTTmfBJGpiUlUA
         N9bVW+Jni1bGKI9eY3YkhVeI3LPT66p6cSVvAhu1AIyVjdv7EkUeoJjjy3rzNdDIph
         hE3I/FXOKqiVR3hwD6MIiJTo8yim3q0L/GkXmma33QZ5ExRlRbfscFL0uIOXuS6ccv
         TGj6t3l1vvyyitG/uq9ilBk3hm7qUD0MfoIDvVRHbQ18iZNwhEIJTchUN0t4ei2LA0
         vZ2f8J+WZ1y8Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>>> The remote-endpoint may not be available if it is part of some
>>> pluggable module. One such example would be an audio card, the
>>> Codec endpoint will not be available until it is plugged in.
>>> Hence drop 'remote-endpoint' as a required property.
>> Please hold off on this. I have more changes coming.

Is this a good time to push for audio-graph-port changes?

