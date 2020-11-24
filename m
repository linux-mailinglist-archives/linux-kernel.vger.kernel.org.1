Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2232C3117
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgKXTpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgKXTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D7C061A54
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:47 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so23613605wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zo5/Lwn9P0icy9iSQMiRZ8fBf7M+D9k/aTR0H18FKHE=;
        b=gb7iP7ck2V3gKzU5e5sqITqk23QP+5qxwgoWtBe2q1dZqOic7g/dmzqayRcG3d8J7G
         DNyBhI81QFKBe+YUSA0U/WP4YRpd0oC65pLVJyJiktRjL0Zyt+oSyl9RytQaUTjj1Tps
         sEl42k0r8jssq/Zc+d42CpkO0ywLRe+vUKZeEqbaPK6+OHLR0STxljOA78pXBGHZ8J/A
         gpTRhRuidU6UXpzbxXwwUOEFyg+c/sJaZ7/TJx/JKLXnpDDz3gaXPTC94R4jGKFwKmA8
         tcmGTRXBDqqqpInFya2BMsV6iRJF9NiFRMli4rWWxA+752QOxl9gjyyizK97eGc8lz9L
         IObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zo5/Lwn9P0icy9iSQMiRZ8fBf7M+D9k/aTR0H18FKHE=;
        b=mVRGBGz6+xsjChdBazcSlqOHV/WNFBF6NYL0pU+k3sES9sx1r5Xpk4k3KfpLDUx3Dg
         8iavM9hcEh5KF3vlDOhUIVOxY2ryuFuEHd/eOq5xDU2W2y4yryZREgMZ4sCZyC+gB3Ch
         p9TBPvTz2rExAaDRoyBK9HAPveG/I7zMrtWvu3Qzg6T92aDOa/Dwl/7iK9YCh1vRW/cQ
         uQqjv2idXyTFxFd1W2vETZ9w5/Pa23s9nncTHhpl5pgA+HmYmdSZLacOR6lO+GopH3MV
         D2eXxGA3/KPv+kzFfSalvmKVG4ciWDonhy+C3R6e76O3UYO8JoiQVlZAsEPqcsuovCyY
         vicw==
X-Gm-Message-State: AOAM532oDlg+XeeisFHIeUeOiuSmQiqELF8Htktmm+4t4IXYw69t3rWF
        YRqZo2+bqiUXF+PS1mNUv/ZtIA==
X-Google-Smtp-Source: ABdhPJzOs9QHReU3r4h3YvKlN8stMtldiU4PjlmQpbAePzGE8iqCbOwjgnvh7S1KGaB2ibGth2Cc3g==
X-Received: by 2002:a5d:400a:: with SMTP id n10mr88321wrp.362.1606247086496;
        Tue, 24 Nov 2020 11:44:46 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 38/40] drm/amd/pm/swsmu/smu11/navi10_ppt: Remove unused 'struct i2c_algorithm navi10_i2c_algo'
Date:   Tue, 24 Nov 2020 19:38:22 +0000
Message-Id: <20201124193824.1118741-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Evan Quan <evan.quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 204 ------------------
 1 file changed, 204 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ef1a62e86a0ee..59bd7cd3ca8df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2325,210 +2325,6 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 	return 0;
 }
 
-static void navi10_fill_i2c_req(SwI2cRequest_t  *req, bool write,
-				  uint8_t address, uint32_t numbytes,
-				  uint8_t *data)
-{
-	int i;
-
-	req->I2CcontrollerPort = 0;
-	req->I2CSpeed = 2;
-	req->SlaveAddress = address;
-	req->NumCmds = numbytes;
-
-	for (i = 0; i < numbytes; i++) {
-		SwI2cCmd_t *cmd =  &req->SwI2cCmds[i];
-
-		/* First 2 bytes are always write for lower 2b EEPROM address */
-		if (i < 2)
-			cmd->Cmd = 1;
-		else
-			cmd->Cmd = write;
-
-
-		/* Add RESTART for read  after address filled */
-		cmd->CmdConfig |= (i == 2 && !write) ? CMDCONFIG_RESTART_MASK : 0;
-
-		/* Add STOP in the end */
-		cmd->CmdConfig |= (i == (numbytes - 1)) ? CMDCONFIG_STOP_MASK : 0;
-
-		/* Fill with data regardless if read or write to simplify code */
-		cmd->RegisterAddr = data[i];
-	}
-}
-
-static int navi10_i2c_read_data(struct i2c_adapter *control,
-					       uint8_t address,
-					       uint8_t *data,
-					       uint32_t numbytes)
-{
-	uint32_t  i, ret = 0;
-	SwI2cRequest_t req;
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct smu_table_context *smu_table = &adev->smu.smu_table;
-	struct smu_table *table = &smu_table->driver_table;
-
-	if (numbytes > MAX_SW_I2C_COMMANDS) {
-		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
-			numbytes, MAX_SW_I2C_COMMANDS);
-		return -EINVAL;
-	}
-
-	memset(&req, 0, sizeof(req));
-	navi10_fill_i2c_req(&req, false, address, numbytes, data);
-
-	mutex_lock(&adev->smu.mutex);
-	/* Now read data starting with that address */
-	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req,
-				   true);
-	mutex_unlock(&adev->smu.mutex);
-
-	if (!ret) {
-		SwI2cRequest_t *res = (SwI2cRequest_t *)table->cpu_addr;
-
-		/* Assume SMU  fills res.SwI2cCmds[i].Data with read bytes */
-		for (i = 0; i < numbytes; i++)
-			data[i] = res->SwI2cCmds[i].Data;
-
-		dev_dbg(adev->dev, "navi10_i2c_read_data, address = %x, bytes = %d, data :",
-				  (uint16_t)address, numbytes);
-
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
-			       8, 1, data, numbytes, false);
-	} else
-		dev_err(adev->dev, "navi10_i2c_read_data - error occurred :%x", ret);
-
-	return ret;
-}
-
-static int navi10_i2c_write_data(struct i2c_adapter *control,
-						uint8_t address,
-						uint8_t *data,
-						uint32_t numbytes)
-{
-	uint32_t ret;
-	SwI2cRequest_t req;
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-
-	if (numbytes > MAX_SW_I2C_COMMANDS) {
-		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
-			numbytes, MAX_SW_I2C_COMMANDS);
-		return -EINVAL;
-	}
-
-	memset(&req, 0, sizeof(req));
-	navi10_fill_i2c_req(&req, true, address, numbytes, data);
-
-	mutex_lock(&adev->smu.mutex);
-	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
-	mutex_unlock(&adev->smu.mutex);
-
-	if (!ret) {
-		dev_dbg(adev->dev, "navi10_i2c_write(), address = %x, bytes = %d , data: ",
-					 (uint16_t)address, numbytes);
-
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
-			       8, 1, data, numbytes, false);
-		/*
-		 * According to EEPROM spec there is a MAX of 10 ms required for
-		 * EEPROM to flush internal RX buffer after STOP was issued at the
-		 * end of write transaction. During this time the EEPROM will not be
-		 * responsive to any more commands - so wait a bit more.
-		 */
-		msleep(10);
-
-	} else
-		dev_err(adev->dev, "navi10_i2c_write- error occurred :%x", ret);
-
-	return ret;
-}
-
-static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
-			      struct i2c_msg *msgs, int num)
-{
-	uint32_t  i, j, ret, data_size, data_chunk_size, next_eeprom_addr = 0;
-	uint8_t *data_ptr, data_chunk[MAX_SW_I2C_COMMANDS] = { 0 };
-
-	for (i = 0; i < num; i++) {
-		/*
-		 * SMU interface allows at most MAX_SW_I2C_COMMANDS bytes of data at
-		 * once and hence the data needs to be spliced into chunks and sent each
-		 * chunk separately
-		 */
-		data_size = msgs[i].len - 2;
-		data_chunk_size = MAX_SW_I2C_COMMANDS - 2;
-		next_eeprom_addr = (msgs[i].buf[0] << 8 & 0xff00) | (msgs[i].buf[1] & 0xff);
-		data_ptr = msgs[i].buf + 2;
-
-		for (j = 0; j < data_size / data_chunk_size; j++) {
-			/* Insert the EEPROM dest addess, bits 0-15 */
-			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
-			data_chunk[1] = (next_eeprom_addr & 0xff);
-
-			if (msgs[i].flags & I2C_M_RD) {
-				ret = navi10_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, MAX_SW_I2C_COMMANDS);
-
-				memcpy(data_ptr, data_chunk + 2, data_chunk_size);
-			} else {
-
-				memcpy(data_chunk + 2, data_ptr, data_chunk_size);
-
-				ret = navi10_i2c_write_data(i2c_adap,
-							      (uint8_t)msgs[i].addr,
-							      data_chunk, MAX_SW_I2C_COMMANDS);
-			}
-
-			if (ret) {
-				num = -EIO;
-				goto fail;
-			}
-
-			next_eeprom_addr += data_chunk_size;
-			data_ptr += data_chunk_size;
-		}
-
-		if (data_size % data_chunk_size) {
-			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
-			data_chunk[1] = (next_eeprom_addr & 0xff);
-
-			if (msgs[i].flags & I2C_M_RD) {
-				ret = navi10_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, (data_size % data_chunk_size) + 2);
-
-				memcpy(data_ptr, data_chunk + 2, data_size % data_chunk_size);
-			} else {
-				memcpy(data_chunk + 2, data_ptr, data_size % data_chunk_size);
-
-				ret = navi10_i2c_write_data(i2c_adap,
-							      (uint8_t)msgs[i].addr,
-							      data_chunk, (data_size % data_chunk_size) + 2);
-			}
-
-			if (ret) {
-				num = -EIO;
-				goto fail;
-			}
-		}
-	}
-
-fail:
-	return num;
-}
-
-static u32 navi10_i2c_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
-}
-
-
-static const struct i2c_algorithm navi10_i2c_algo = {
-	.master_xfer = navi10_i2c_xfer,
-	.functionality = navi10_i2c_func,
-};
-
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
-- 
2.25.1

